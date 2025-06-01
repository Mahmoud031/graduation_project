import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/helper_functions/get_dummy_medicine_invnetory.dart';
import 'package:graduation_project/core/widgets/custom_error.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/cubit/medicine_invnetory_cubit/medicine_inventory_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';
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
