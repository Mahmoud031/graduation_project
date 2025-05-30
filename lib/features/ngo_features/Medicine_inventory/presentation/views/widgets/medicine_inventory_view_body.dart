import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/cubit/medicine_invnetory_cubit/medicine_inventory_cubit.dart';
import '../../../../../../core/widgets/summary_card.dart';
import 'medicine_inventory_card_bloc_builder.dart';


class MedicineInventoryViewBody extends StatefulWidget {
  const MedicineInventoryViewBody({super.key});

  @override
  State<MedicineInventoryViewBody> createState() =>
      _MedicineInventoryViewBodyState();
}

class _MedicineInventoryViewBodyState extends State<MedicineInventoryViewBody> {
  @override
  void initState() {
    context.read<MedicineInventoryCubit>().getMedicineInventory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Medicine Inventory',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SummaryCard(
                color: Color(0xFF23B3A7),
                count: '120',
                label: 'Types\nMedicine ',
              ),
              SummaryCard(
                color: Color(0xFF3DC88F),
                count: '650',
                label: 'Units\nIn Stock',
              ),
              SummaryCard(
                color: Color(0xFFF7B84B),
                count: '20',
                label: 'Units\nLow Stock',
              ),
              SummaryCard(
                color: Color(0xFFF26A5B),
                count: '15',
                label: 'Uniting\nExpiring Soon',
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  side: const BorderSide(color: Colors.black12),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
                child: const Text('Filter'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: MedicineInventoryCardBlocBuilder(),
          ),
        ],
      ),
    );
  }
}
