import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/cubits/medicine_cubit/medicine_cubit.dart';
import 'package:graduation_project/core/widgets/summary_card.dart';

class DonationManagementHeader extends StatelessWidget {
  const DonationManagementHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicineCubit, dynamic>(
      builder: (context, state) {
        if (state is MedicineSuccess) {
          final medicines = state.medicines;
          final totalShipments = medicines.length;
          final inTransitShipments = medicines.where((m) => m.status.toLowerCase() == 'pending' || m.status.toLowerCase() == 'approved').length;
          final deliveredShipments = medicines.where((m) => m.status.toLowerCase() == 'delivered').length;
          final cancelledShipments = medicines.where((m) => m.status.toLowerCase() == 'rejected').length;

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
                      count: totalShipments.toString(),
                      label: 'Total\nShipments',
                    ),
                    const SizedBox(width: 12),
                    SummaryCard(
                      color: const Color(0xFF6B6BD6),
                      count: inTransitShipments.toString(),
                      label: 'Shipments\nin Transit',
                    ),
                    const SizedBox(width: 12),
                    SummaryCard(
                      color: const Color(0xFFF7B84B),
                      count: deliveredShipments.toString(),
                      label: 'Delivered\nShipments',
                    ),
                    const SizedBox(width: 12),
                    SummaryCard(
                      color: const Color(0xFFF26A5B),
                      count: cancelledShipments.toString(),
                      label: 'Cancelled\nShipments',
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
                    label: 'Total\nShipments',
                  ),
                  SizedBox(width: 12),
                  SummaryCard(
                    color: Color(0xFF6B6BD6),
                    count: '0',
                    label: 'Shipments\nin Transit',
                  ),
                  SizedBox(width: 12),
                  SummaryCard(
                    color: Color(0xFFF7B84B),
                    count: '0',
                    label: 'Delivered\nShipments',
                  ),
                  SizedBox(width: 12),
                  SummaryCard(
                    color: Color(0xFFF26A5B),
                    count: '0',
                    label: 'Cancelled\nShipments',
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
