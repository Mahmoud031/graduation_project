import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/cubit/medicine_invnetory_cubit/medicine_inventory_cubit.dart';
import 'package:graduation_project/core/widgets/summary_card.dart';

int parseQuantity(String? value) {
  if (value == null) return 0;
  final match = RegExp(r'^(\d+)').firstMatch(value.trim());
  if (match != null) {
    return int.tryParse(match.group(1)!) ?? 0;
  }
  return 0;
}

class MedicineInventoryHeader extends StatelessWidget {
  const MedicineInventoryHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicineInventoryCubit, dynamic>(
      builder: (context, state) {
        if (state is MedicineInventorySuccess) {
          final medicines = state.medicines;
          final uniqueTypes =
              medicines.map((m) => m.medicineName).toSet().length;
          final totalUnits = medicines.fold<int>(
              0, (sum, m) => sum + parseQuantity(m.quantityAvailable));
          final lowStock = medicines
              .where((m) => parseQuantity(m.quantityAvailable) < 10)
              .length;
          final now = DateTime.now();
          final expiringSoon = medicines.where((m) {
            try {
              final parts = m.expiryDate.split('/');
              if (parts.length != 3) return false;
              final expDate = DateTime(int.parse(parts[2]), int.parse(parts[1]),
                  int.parse(parts[0]));
              return expDate.isAfter(now) &&
                  expDate.isBefore(now.add(const Duration(days: 30)));
            } catch (_) {
              return false;
            }
          }).length;

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
                      count: uniqueTypes.toString(),
                      label: 'Types\nMedicine',
                    ),
                    const SizedBox(width: 12),
                    SummaryCard(
                      color: const Color(0xFF3DC88F),
                      count: totalUnits.toString(),
                      label: 'Units\nIn Stock',
                    ),
                    const SizedBox(width: 12),
                    SummaryCard(
                      color: const Color(0xFFF7B84B),
                      count: lowStock.toString(),
                      label: 'Units\nLow Stock',
                    ),
                    const SizedBox(width: 12),
                    SummaryCard(
                      color: const Color(0xFFF26A5B),
                      count: expiringSoon.toString(),
                      label: 'Units\nExpiring Soon',
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
                    label: 'Types\nMedicine',
                  ),
                  SizedBox(width: 12),
                  SummaryCard(
                    color: Color(0xFF3DC88F),
                    count: '0',
                    label: 'Units\nIn Stock',
                  ),
                  SizedBox(width: 12),
                  SummaryCard(
                    color: Color(0xFFF7B84B),
                    count: '0',
                    label: 'Units\nLow Stock',
                  ),
                  SizedBox(width: 12),
                  SummaryCard(
                    color: Color(0xFFF26A5B),
                    count: '0',
                    label: 'Units\nExpiring Soon',
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
