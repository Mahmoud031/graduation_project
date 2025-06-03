import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/cubits/medicine_cubit/medicine_cubit.dart';

class StatisticsGrid extends StatelessWidget {
  const StatisticsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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

            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _buildStatCard('Total Donations', '$totalDonations',
                    Icons.card_giftcard, Colors.orangeAccent),
                _buildStatCard('Completed', '$completedDonations',
                    Icons.check_circle, Colors.greenAccent.shade400),
                _buildStatCard('Pending', '$pendingDonations',
                    Icons.pending_actions, Colors.blueAccent.shade100),
                _buildStatCard('Total Tablets', '$totalTablets',
                    Icons.medical_services, Colors.purpleAccent.shade100),
              ],
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
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}