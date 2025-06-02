import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/cubits/medicine_cubit/medicine_cubit.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import 'package:get_it/get_it.dart';
import 'package:graduation_project/features/donor_features/add_medicine/domain/repos/medicine_repo.dart';

class MedicineInventoryDonationsReport extends StatelessWidget {
  const MedicineInventoryDonationsReport({super.key});
  static const routeName = 'medicine-inventory-donations-report';

  @override
  Widget build(BuildContext context) {
    final ngo = getNgo();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine Inventory Donations'),
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

              // Filter medicines by status
              final pendingDonations =
                  ngoMedicines.where((m) => m.status == 'pending').length;
              final approvedDonations =
                  ngoMedicines.where((m) => m.status == 'approved').length;
              final deliveredDonations =
                  ngoMedicines.where((m) => m.status == 'delivered').length;
              final rejectedDonations =
                  ngoMedicines.where((m) => m.status == 'rejected').length;

              // Calculate total donations for this NGO
              final totalDonations = ngoMedicines.length;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Summary Cards
                    Row(
                      children: [
                        Expanded(
                          child: _buildSummaryCard(
                            'Total Donations',
                            totalDonations.toString(),
                            const Color(0xFF23B3A7),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildSummaryCard(
                            'In Progress',
                            pendingDonations.toString(),
                            const Color(0xFF6B6BD6),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildSummaryCard(
                            'Completed',
                            deliveredDonations.toString(),
                            const Color(0xFFF26A5B),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildSummaryCard(
                            'Rejected',
                            rejectedDonations.toString(),
                            const Color(0xFFF7B84B),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Donation Status Pie Chart
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Donation Status Distribution',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 300,
                              child: PieChart(
                                PieChartData(
                                  sections: [
                                    PieChartSectionData(
                                      value: pendingDonations.toDouble(),
                                      title: 'Pending\n$pendingDonations',
                                      color: const Color(0xFF6B6BD6),
                                      radius: 100,
                                    ),
                                    PieChartSectionData(
                                      value: deliveredDonations.toDouble(),
                                      title: 'Delivered\n$deliveredDonations',
                                      color: const Color(0xFFF26A5B),
                                      radius: 100,
                                    ),
                                    PieChartSectionData(
                                      value: rejectedDonations.toDouble(),
                                      title: 'Rejected\n$rejectedDonations',
                                      color: const Color(0xFFF7B84B),
                                      radius: 100,
                                    ),
                                  ],
                                  sectionsSpace: 2,
                                  centerSpaceRadius: 40,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildStatusDescription(
                              pendingDonations,
                              deliveredDonations,
                              rejectedDonations,
                              totalDonations,
                            ),
                          ],
                        ),
                      ),
                    ),
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

  Widget _buildSummaryCard(String title, String count, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              count,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusDescription(
    int pending,
    int delivered,
    int rejected,
    int total,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Status Overview',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '• ${_calculatePercentage(pending, total)}% of donations are pending review',
          style: const TextStyle(fontSize: 14),
        ),
        Text(
          '• ${_calculatePercentage(delivered, total)}% of donations have been delivered',
          style: const TextStyle(fontSize: 14),
        ),
        Text(
          '• ${_calculatePercentage(rejected, total)}% of donations were rejected',
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  double _calculatePercentage(int value, int total) {
    if (total == 0) return 0;
    return ((value / total) * 100).roundToDouble();
  }
}
