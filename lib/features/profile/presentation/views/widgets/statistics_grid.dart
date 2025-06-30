import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/cubits/medicine_cubit/medicine_cubit.dart';

class StatisticsGrid extends StatelessWidget {
  const StatisticsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double maxCrossAxisExtent = width > 600 ? 300 : 200;
    double childAspectRatio = width > 600 ? 1.2 : 0.9;
    double spacing = width * 0.04;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spacing),
      child: BlocBuilder<MedicineCubit, MedicineState>(
        builder: (context, state) {
          if (state is MedicineLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MedicineSuccess) {
            final medicines = state.medicines;
            final totalDonations = medicines.length;
            final completedDonations = medicines
                .where((m) => m.status.toLowerCase() == 'delivered')
                .length;
            final pendingDonations = medicines
                .where((m) => m.status.toLowerCase() == 'pending')
                .length;
            final totalTablets = medicines.fold<int>(0, (sum, m) {
              final count = int.tryParse(m.tabletCount) ?? 0;
              return sum + count;
            });

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: maxCrossAxisExtent,
                mainAxisSpacing: spacing,
                crossAxisSpacing: spacing,
                childAspectRatio: childAspectRatio,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return _buildStatCard('Total Donations', '$totalDonations',
                        Icons.card_giftcard, Colors.orangeAccent, width);
                  case 1:
                    return _buildStatCard('Completed', '$completedDonations',
                        Icons.check_circle, Colors.greenAccent.shade400, width);
                  case 2:
                    return _buildStatCard(
                        'Pending',
                        '$pendingDonations',
                        Icons.pending_actions,
                        Colors.blueAccent.shade100,
                        width);
                  case 3:
                    return _buildStatCard(
                        'Total Tablets',
                        '$totalTablets',
                        Icons.medical_services,
                        Colors.purpleAccent.shade100,
                        width);
                  default:
                    return const SizedBox.shrink();
                }
              },
            );
          }

          if (state is MedicineFailure) {
            return Center(
              child: Text(
                'Error: ${state.errorMessage}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return const Center(child: Text('No data available'));
        },
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color, double width) {
    return Container(
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 4),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: width > 600 ? 40 : 32, color: color),
          SizedBox(height: width * 0.015),
          Text(
            value,
            style: TextStyle(
              fontSize: width > 600 ? 28 : 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: width * 0.01),
          Text(
            title,
            style: TextStyle(
              fontSize: width > 600 ? 16 : 14,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
