import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/cubit/medicine_invnetory_cubit/medicine_inventory_cubit.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/domain/entities/medicine_invnetory_entity.dart';
import 'package:intl/intl.dart';

class DonationsOverTimeReport extends StatelessWidget {
  const DonationsOverTimeReport({super.key});
  static const routeName = 'donations-over-time-report';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Donations Over Time')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocBuilder<MedicineInventoryCubit, MedicineInventoryState>(
              builder: (context, state) {
                if (state is MedicineInventoryLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MedicineInventoryFailure) {
                  return Center(child: Text(state.message));
                } else if (state is MedicineInventorySuccess) {
                  final medicines = state.medicines;
                  if (medicines.isEmpty) {
                    return const Center(
                        child: Text('No donation data available.'));
                  }
                  // Group by month
                  final Map<String, int> monthToQuantity = {};
                  final dateFormat = DateFormat('d/M/yyyy');
                  final monthFormat = DateFormat('MMM yyyy');

                  for (final med in medicines) {
                    try {
                      final date = dateFormat.parse(med.recievedDate);
                      final month = monthFormat.format(date);
                      monthToQuantity[month] =
                          (monthToQuantity[month] ?? 0) + 1;
                    } catch (_) {
                      // skip invalid dates
                    }
                  }

                  // Sort months chronologically
                  final sortedMonths = monthToQuantity.keys.toList()
                    ..sort((a, b) =>
                        monthFormat.parse(a).compareTo(monthFormat.parse(b)));

                  final totalDonations = monthToQuantity.values.fold<int>(0, (a, b) => a + b);
                  final maxDonations = monthToQuantity.values.isNotEmpty
                      ? monthToQuantity.values.reduce((a, b) => a > b ? a : b)
                      : 0;
                  final maxMonth = monthToQuantity.entries
                      .firstWhere((e) => e.value == maxDonations, orElse: () => MapEntry('', 0))
                      .key;
                  final avgDonations = monthToQuantity.values.isNotEmpty
                      ? (totalDonations / monthToQuantity.length).toStringAsFixed(1)
                      : '0';

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Donation Trends',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Track how donations have changed over time.',
                        style: TextStyle(fontSize: 15, color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.teal.withOpacity(0.08),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(12),
                        child: SizedBox(
                          height: 360,
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              barTouchData: BarTouchData(
                                enabled: true,
                                touchTooltipData: BarTouchTooltipData(
                                  getTooltipColor: (group) =>
                                      Colors.teal.withOpacity(0.8),
                                  getTooltipItem:
                                      (group, groupIndex, rod, rodIndex) {
                                    return BarTooltipItem(
                                      '${sortedMonths[group.x.toInt()]}\n',
                                      const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      children: [
                                        TextSpan(
                                          text: 'Donations: ${rod.toY.toInt()}',
                                          style: const TextStyle(
                                              color: Colors.white70,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: true,
                                getDrawingHorizontalLine: (value) => FlLine(
                                  color: Colors.grey.withOpacity(0.15),
                                  strokeWidth: 1,
                                ),
                                getDrawingVerticalLine: (value) => FlLine(
                                  color: Colors.grey.withOpacity(0.10),
                                  strokeWidth: 1,
                                ),
                              ),
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 40,
                                    getTitlesWidget: (value, meta) {
                                      // Only show integer values
                                      if (value % 1 == 0) {
                                        return Text(
                                          value.toInt().toString(),
                                          style: const TextStyle(fontSize: 12),
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                  axisNameWidget: const Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Text('Donations',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      final idx = value.toInt();
                                      if (idx < 0 || idx >= sortedMonths.length)
                                        return const SizedBox.shrink();
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(sortedMonths[idx],
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500)),
                                      );
                                    },
                                  ),
                                  axisNameWidget: const Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Text('Month',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                              ),
                              borderData: FlBorderData(
                                show: true,
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.15)),
                              ),
                              minY: 0,
                              maxY: monthToQuantity.values.isNotEmpty
                                  ? (monthToQuantity.values
                                          .reduce((a, b) => a > b ? a : b) +
                                      2)
                                  : 2,
                              barGroups:
                                  List.generate(sortedMonths.length, (i) {
                                return BarChartGroupData(
                                  x: i,
                                  barRods: [
                                    BarChartRodData(
                                      toY: monthToQuantity[sortedMonths[i]]!
                                          .toDouble(),
                                      color: Colors.teal,
                                      width: 22,
                                      borderRadius: BorderRadius.circular(8),
                                      backDrawRodData:
                                          BackgroundBarChartRodData(
                                        show: true,
                                        toY: 0,
                                        color: Colors.teal.withOpacity(0.08),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Description under the chart
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 18),
                        decoration: BoxDecoration(
                          color: Colors.teal.withOpacity(0.07),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'This chart shows the number of donations received each month.\n'
                          'Total donations: $totalDonations\n'
                          'Highest month: ${maxMonth.isNotEmpty ? maxMonth : 'N/A'} (${maxDonations} donations)\n'
                          'Average per month: $avgDonations',
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black87, height: 1.4),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
