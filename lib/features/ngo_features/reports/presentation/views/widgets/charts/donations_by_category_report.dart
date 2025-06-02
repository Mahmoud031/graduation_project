import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/cubit/medicine_invnetory_cubit/medicine_inventory_cubit.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';

class DonationsByCategoryReport extends StatelessWidget {
  const DonationsByCategoryReport({super.key});
  static const routeName = 'donations-by-category-report';

  static const List<Color> barColors = [
    Color(0xFF23B3A7),
    Color(0xFF6B6BD6),
    Color(0xFFF26A5B),
    Color(0xFFF7B84B),
    Color(0xFF4DD599),
    Color(0xFFB388FF),
    Color(0xFFFF8A65),
    Color(0xFF90CAF9),
  ];

  @override
  Widget build(BuildContext context) {
    final ngo = getNgo();
    return Scaffold(
      appBar: AppBar(title: const Text('Donations by Category')),
      body: BlocBuilder<MedicineInventoryCubit, MedicineInventoryState>(
        builder: (context, state) {
          if (state is MedicineInventoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MedicineInventoryFailure) {
            return Center(child: Text('Error: ${state.message}'));
          }
          if (state is MedicineInventorySuccess) {
            final ngoMedicines =
                state.medicines.where((m) => m.ngoUId == ngo.uId).toList();
            final Map<String, int> categoryCounts = {};
            for (final med in ngoMedicines) {
              categoryCounts[med.category] =
                  (categoryCounts[med.category] ?? 0) + 1;
            }
            final categories = categoryCounts.keys.toList();
            final counts = categoryCounts.values.toList();
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stylish header
                    Row(
                      children: const [
                        Icon(Icons.category,
                            color: Color(0xFF23B3A7), size: 32),
                        SizedBox(width: 12),
                        Text(
                          'Donations by Category',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'See how your donations are distributed across all medicine categories.',
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                    const SizedBox(height: 24),
                    // Chart Card
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFE0F7FA),
                              Color(0xFFF1F8E9),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 16,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(32, 30, 20, 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 340,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: SizedBox(
                                    width: (categories.length * 120)
                                        .toDouble()
                                        .clamp(320, 2000),
                                    child: BarChart(
                                      BarChartData(
                                        alignment: BarChartAlignment.spaceBetween,
                                        maxY: (counts.isNotEmpty
                                            ? (counts.reduce(
                                                        (a, b) => a > b ? a : b) +
                                                    1)
                                                .toDouble()
                                            : 1),
                                        barTouchData: BarTouchData(
                                          enabled: true,
                                          touchTooltipData: BarTouchTooltipData(
                                            tooltipBorderRadius:
                                                BorderRadius.circular(8),
                                            tooltipPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 12, vertical: 8),
                                            tooltipMargin: 8,
                                            getTooltipItem: (group, groupIndex,
                                                rod, rodIndex) {
                                              return BarTooltipItem(
                                                '${categories[group.x]}\n',
                                                const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: Colors.black87),
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        '${rod.toY.toInt()} donations',
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black54),
                                                  ),
                                                ],
                                              );
                                            },
                                            direction: TooltipDirection.top,
                                          ),
                                        ),
                                        titlesData: FlTitlesData(
                                          leftTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              getTitlesWidget: (value, meta) {
                                                if (value % 1 == 0 &&
                                                    value >= 0 &&
                                                    value <=
                                                        (counts.isNotEmpty
                                                            ? (counts.reduce((a,
                                                                        b) =>
                                                                    a > b
                                                                        ? a
                                                                        : b) +
                                                                1)
                                                            : 1)) {
                                                  return Text(
                                                      value.toInt().toString(),
                                                      style: const TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500));
                                                }
                                                return const SizedBox.shrink();
                                              },
                                              interval: 1,
                                              reservedSize: 56,
                                            ),
                                          ),
                                          bottomTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              getTitlesWidget: (value, meta) {
                                                final idx = value.toInt();
                                                if (idx < 0 ||
                                                    idx >= categories.length) {
                                                  return const SizedBox.shrink();
                                                }
                                                return Transform.rotate(
                                                  angle: -0.5,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 16.0),
                                                    child: Text(
                                                      categories[idx],
                                                      style: const TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black87),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    ),
                                                  ),
                                                );
                                              },
                                              reservedSize: 60,
                                            ),
                                          ),
                                          rightTitles: AxisTitles(
                                              sideTitles:
                                                  SideTitles(showTitles: false)),
                                          topTitles: AxisTitles(
                                              sideTitles:
                                                  SideTitles(showTitles: false)),
                                        ),
                                        borderData: FlBorderData(show: false),
                                        gridData: FlGridData(show: false),
                                        barGroups:
                                            List.generate(categories.length, (i) {
                                          return BarChartGroupData(
                                            x: i,
                                            barRods: [
                                              BarChartRodData(
                                                toY: counts[i].toDouble(),
                                                color: barColors[
                                                    i % barColors.length],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                width: 36,
                                              ),
                                            ],
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Description Card
                    Card(
                      color: const Color(0xFFF7F9FA),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: _buildDescription(categoryCounts),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text('No data available'));
        },
      ),
    );
  }

  Widget _buildDescription(Map<String, int> categoryCounts) {
    if (categoryCounts.isEmpty) {
      return const Text('No donations have been made in any category yet.',
          style: TextStyle(fontSize: 15));
    }
    final sorted = categoryCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final top = sorted.first;
    return Text(
      'The most donated category is "${top.key}" with ${top.value} donations.\n'
      'Here you can see how donations are distributed across all categories.',
      style: const TextStyle(fontSize: 15),
    );
  }
}
