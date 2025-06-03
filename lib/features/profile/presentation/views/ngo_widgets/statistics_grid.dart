import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/cubits/medicine_cubit/medicine_cubit.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/core/utils/string_utils.dart';

class StatisticsGrid extends StatelessWidget {
  const StatisticsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Statistics',
              style: TextStyles.textstyle18.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 16),
            BlocBuilder<MedicineCubit, MedicineState>(
              builder: (context, state) {
                if (state is MedicineLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MedicineFailure) {
                  return Center(child: Text(state.errorMessage));
                } else if (state is MedicineSuccess) {
                  final ngoUId = state.medicines.isNotEmpty ? state.medicines.first.ngoUId : '';
                  final medicines = state.medicines.where((m) => m.ngoUId == ngoUId).toList();
                  final approved = medicines.where((m) => m.status.toLowerCase() == 'approved').toList();
                  final totalDonations = medicines.length;
                  final pendingRequests = medicines.where((m) => m.status.toLowerCase() == 'pending').length;
                  final activeInventory = approved.fold<int>(0, (sum, m) => sum + extractLeadingNumber(m.tabletCount));
                  final numberOfDonors = medicines.map((m) => m.donorName).toSet().where((d) => d.isNotEmpty).length;
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.2,
                    children: [
                      _StatCard('Total Donations', '$totalDonations', Icons.card_giftcard, Colors.orangeAccent),
                      _StatCard('Active Inventory', '$activeInventory', Icons.medical_services, Colors.greenAccent.shade400),
                      _StatCard('Number of Donors', '$numberOfDonors', Icons.people, Colors.purpleAccent.shade100),
                      _StatCard('Pending Requests', '$pendingRequests', Icons.pending_actions, Colors.blueAccent.shade100),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  const _StatCard(this.title, this.value, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(10),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyles.textstyle18.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 22,
            ),
          ),
          Text(
            title,
            style: TextStyles.textstyle14.copyWith(
              color: Colors.blueGrey,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
} 