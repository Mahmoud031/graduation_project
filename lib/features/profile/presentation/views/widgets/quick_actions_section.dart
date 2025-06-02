import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/features/ngo_features/Donations/presentation/views/ngo_donations_view.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/views/medicine_inventory_view.dart';
import 'package:graduation_project/features/ngo_features/Donation_Management/presentation/views/donation_management_view.dart';
import 'package:graduation_project/features/ngo_features/reports/presentation/views/reports_view.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

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
              'Quick Actions',
              style: TextStyles.textstyle18.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  context,
                  'Donations',
                  Icons.card_giftcard,
                  () => Navigator.pushNamed(context, NgoDonationsView.routeName),
                  color: Colors.orangeAccent,
                ),
                _buildActionButton(
                  context,
                  'Inventory',
                  Icons.medical_services,
                  () => Navigator.pushNamed(context, MedicineInventoryView.routeName),
                  color: Colors.greenAccent.shade400,
                ),
                _buildActionButton(
                  context,
                  'Management',
                  Icons.manage_accounts,
                  () => Navigator.pushNamed(context, DonationManagementView.routeName),
                  color: Colors.purpleAccent.shade100,
                ),
                _buildActionButton(
                  context,
                  'Reports',
                  Icons.bar_chart,
                  () => Navigator.pushNamed(context, ReportsView.routeName),
                  color: Colors.blueAccent.shade100,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onPressed, {
    required Color color,
  }) {
    return Column(
      children: [
        Material(
          color: color,
          shape: const CircleBorder(),
          elevation: 4,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyles.textstyle14.copyWith(
            color: Colors.blueGrey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
} 