import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/cubits/medicine_cubit/medicine_cubit.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import 'package:get_it/get_it.dart';
import 'package:graduation_project/features/donor_features/add_medicine/domain/repos/medicine_repo.dart';

class DonorPerformanceReport extends StatelessWidget {
  const DonorPerformanceReport({super.key});
  static const routeName = 'donor-performance-report';

  @override
  Widget build(BuildContext context) {
    final ngo = getNgo();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donor Performance Report'),
      ),
      body: BlocProvider(
        create: (context) => MedicineCubit(GetIt.I<MedicineRepo>())
          ..listenToNgoMedicines(ngo.uId),
        child: BlocBuilder<MedicineCubit, MedicineState>(
          builder: (context, state) {
            if (state is MedicineLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is MedicineFailure) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            }

            if (state is MedicineSuccess) {
              // Filter medicines for current NGO only
              final ngoMedicines =
                  state.medicines.where((m) => m.ngoUId == ngo.uId).toList();

              // Process donor data
              final donorStats = _processDonorData(ngoMedicines);
              final topDonors = _getTopDonors(donorStats);
              final donorEngagement = _calculateDonorEngagement(donorStats);

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTopDonorsCard(topDonors),
                    const SizedBox(height: 24),
                    _buildDonorEngagementChart(donorEngagement),
                    const SizedBox(height: 24),
                    _buildDonorReliabilityCard(donorStats),
                  ],
                ),
              );
            }

            return const Center(child: Text('No data available'));
          },
        ),
      ),
    );
  }

  Map<String, DonorStats> _processDonorData(List<dynamic> medicines) {
    final Map<String, DonorStats> donorStats = {};
    for (final medicine in medicines) {
      final donorName = medicine.donorName;
      if (!donorStats.containsKey(donorName)) {
        donorStats[donorName] = DonorStats(
          name: donorName,
          totalDonations: 0,
          totalQuantity: 0,
          lastDonationDate: null,
          firstDonationDate: null,
          successfulDonations: 0,
          donationDates: [],
        );
      }
      final stats = donorStats[donorName]!;
      stats.totalDonations++;
      stats.totalQuantity += int.tryParse(medicine.tabletCount) ?? 0;
      final donationDate = _parseDate(medicine.receivedDate);
      if (donationDate != null) {
        stats.donationDates!.add(donationDate);
        if (stats.lastDonationDate == null ||
            donationDate.isAfter(stats.lastDonationDate!)) {
          stats.lastDonationDate = donationDate;
        }
        if (stats.firstDonationDate == null ||
            donationDate.isBefore(stats.firstDonationDate!)) {
          stats.firstDonationDate = donationDate;
        }
      }
      if (medicine.status.toLowerCase() == 'delivered') {
        stats.successfulDonations++;
      }
    }
    return donorStats;
  }

  DateTime? _parseDate(String dateStr) {
    try {
      if (dateStr.contains('/')) {
        final parts = dateStr.split('/');
        if (parts.length == 3) {
          return DateTime(
            int.parse(parts[2]),
            int.parse(parts[1]),
            int.parse(parts[0]),
          );
        }
      } else {
        return DateTime.parse(dateStr);
      }
    } catch (_) {}
    return null;
  }

  List<DonorStats> _getTopDonors(Map<String, DonorStats> donorStats) {
    final donors = donorStats.values.toList();
    donors.sort((a, b) => b.totalQuantity.compareTo(a.totalQuantity));
    return donors.take(5).toList();
  }

  Map<String, List<int>> _calculateDonorEngagement(
      Map<String, DonorStats> donorStats) {
    final Map<String, List<int>> engagement = {};
    final now = DateTime.now();
    final months = 6; // Track last 6 months
    final monthLabels = List.generate(months, (i) {
      final date = DateTime(now.year, now.month - (months - 1 - i));
      return DateTime(date.year, date.month);
    });

    for (final donor in donorStats.values) {
      final monthlyDonations = List<int>.filled(months, 0);
      if (donor.donationDates != null) {
        for (final date in donor.donationDates!) {
          for (int i = 0; i < months; i++) {
            if (date.year == monthLabels[i].year &&
                date.month == monthLabels[i].month) {
              monthlyDonations[i]++;
            }
          }
        }
      }
      engagement[donor.name] = monthlyDonations;
    }
    return engagement;
  }

  Widget _buildTopDonorsCard(List<DonorStats> topDonors) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Top Donors',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...topDonors.map((donor) => _buildDonorRow(donor)),
          ],
        ),
      ),
    );
  }

  Widget _buildDonorRow(DonorStats donor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  donor.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${donor.totalDonations} donations',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${donor.totalQuantity} tablets',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF23B3A7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDonorEngagementChart(Map<String, List<int>> engagement) {
    final months = 6;
    final now = DateTime.now();
    final monthLabels = List.generate(months, (i) {
      final date = DateTime(now.year, now.month - (months - 1 - i));
      return _monthShort(date.month);
    });
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Donor Engagement Over Time',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          if (value % 1 == 0) {
                            return Text(value.toInt().toString());
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value >= 0 && value < months) {
                            return Text(monthLabels[value.toInt()]);
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: engagement.entries.map((entry) {
                    return LineChartBarData(
                      spots: entry.value.asMap().entries.map((e) {
                        return FlSpot(e.key.toDouble(), e.value.toDouble());
                      }).toList(),
                      isCurved: true,
                      color: const Color(0xFF23B3A7),
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _monthShort(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month];
  }

  Widget _buildDonorReliabilityCard(Map<String, DonorStats> donorStats) {
    final reliableDonors = donorStats.values
        .where((d) => d.successfulDonations / d.totalDonations >= 0.8)
        .toList();
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Most Reliable Donors',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            if (reliableDonors.isEmpty)
              const Text(
                'No reliable donors found.',
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ...reliableDonors.map((donor) => _buildReliabilityRow(donor)),
          ],
        ),
      ),
    );
  }

  Widget _buildReliabilityRow(DonorStats donor) {
    final reliability =
        (donor.successfulDonations / donor.totalDonations * 100).round();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  donor.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${donor.totalDonations} total donations',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            '$reliability% reliable',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: reliability >= 90 ? Colors.green : Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}

class DonorStats {
  final String name;
  int totalDonations;
  int totalQuantity;
  DateTime? lastDonationDate;
  DateTime? firstDonationDate;
  int successfulDonations;
  List<DateTime>? donationDates;

  DonorStats({
    required this.name,
    required this.totalDonations,
    required this.totalQuantity,
    this.lastDonationDate,
    this.firstDonationDate,
    required this.successfulDonations,
    this.donationDates,
  });
}
