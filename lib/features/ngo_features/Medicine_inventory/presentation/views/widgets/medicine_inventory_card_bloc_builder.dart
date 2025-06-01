import 'package:flutter/material.dart';
import 'medicine_inventory_card_items.dart';

class MedicineInventoryCardBlocBuilder extends StatelessWidget {
  final List<dynamic> medicines;
  
  const MedicineInventoryCardBlocBuilder({
    super.key,
    required this.medicines,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: medicines.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: MedicineInventoryCardItems(
            medicineEntity: medicines[index],
          ),
        ),
      ),
    );
  }
}
