import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/cubits/medicine_cubit/medicine_cubit.dart';
import 'package:graduation_project/core/widgets/summary_card.dart';

class DonationsHeader extends StatelessWidget {
  const DonationsHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicineCubit, dynamic>(
      builder: (context, state) {
        if (state is MedicineSuccess) {
          final medicines = state.medicines;
          final totalDonations = medicines.length;
          final approvedDonations = medicines
              .where((m) => m.status.toLowerCase() == 'approved')
              .length;
          final rejectedDonations = medicines
              .where((m) => m.status.toLowerCase() == 'rejected')
              .length;
          final deliveredDonations = medicines
              .where((m) => m.status.toLowerCase() == 'delivered')
              .length;
          final pendingDonations = medicines
              .where((m) => m.status.toLowerCase() == 'pending')
              .length;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              height: 90,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    SummaryCard(
                      color: const Color(0xFF23B3A7),
                      count: totalDonations.toString(),
                      label: 'Total\nDonations',
                    ),
                    const SizedBox(width: 12),
                    SummaryCard(
                      color: const Color(0xFF4CAF50),
                      count: approvedDonations.toString(),
                      label: 'Approved',
                    ),
                    const SizedBox(width: 12),
                    SummaryCard(
                      color: const Color(0xFFF26A5B),
                      count: rejectedDonations.toString(),
                      label: 'Rejected',
                    ),
                    const SizedBox(width: 12),
                    SummaryCard(
                      color: const Color(0xFF3B7BFF),
                      count: deliveredDonations.toString(),
                      label: 'Delivered',
                    ),
                    const SizedBox(width: 12),
                    SummaryCard(
                      color: const Color(0xFFF7B84B),
                      count: pendingDonations.toString(),
                      label: 'Pending',
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),
          );
        }
        // Loading/empty state
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SizedBox(
            height: 90,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const [
                  SizedBox(width: 8),
                  SummaryCard(
                    color: Color(0xFF23B3A7),
                    count: '0',
                    label: 'Total\nDonations',
                  ),
                  SizedBox(width: 12),
                  SummaryCard(
                    color: Color(0xFF6B6BD6),
                    count: '0',
                    label: 'Approved',
                  ),
                  SizedBox(width: 12),
                  SummaryCard(
                    color: Color(0xFFF26A5B),
                    count: '0',
                    label: 'Rejected',
                  ),
                  SizedBox(width: 12),
                  SummaryCard(
                    color: Color(0xFFF7B84B),
                    count: '0',
                    label: 'Delivered',
                  ),
                  SizedBox(width: 12),
                  SummaryCard(
                    color: Color(0xFF4CAF50),
                    count: '0',
                    label: 'Pending',
                  ),
                  SizedBox(width: 8),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
