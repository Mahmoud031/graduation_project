import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/helper_functions/get_dummy_medicine_invnetory.dart';
import 'package:graduation_project/core/widgets/custom_error.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/cubit/medicine_invnetory_cubit/medicine_inventory_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'medicine_inventory_card_items.dart';

class MedicineInventoryCardBlocBuilder extends StatelessWidget {
  const MedicineInventoryCardBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicineInventoryCubit, MedicineInventoryState>(
      builder: (context, state) {
        if (state is MedicineInventorySuccess) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: state.medicines.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: MedicineInventoryCardItems(
                  medicineEntity: state.medicines[index],
                ),
              ),
            ),
          );
        } else if (state is MedicineInventoryFailure) {
          return CustomError(text: state.message);
        } else {
          final dummyList = getDummyMedicineInventoryList();
          return Skeletonizer(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: dummyList.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: MedicineInventoryCardItems(
                    medicineEntity: dummyList[index],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
