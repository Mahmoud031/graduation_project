import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/helper_functions/build_error_bar.dart';
import 'package:graduation_project/core/widgets/success_dialog.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../cubit/add_medicine_to_inventory_cubit/add_medicine_to_inventory_cubit.dart';
import 'add_medicine_dialog.dart';

class AddMedicineDialogBlocConsumer extends StatelessWidget {
  const AddMedicineDialogBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddMedicineToInventoryCubit, AddMedicineToInventoryState>(
      listenWhen: (previous, current) => 
        current is AddMedicineToInventorySuccess || 
        current is AddMedicineToInventoryFailure,
      listener: (context, state) {
        if(state is AddMedicineToInventorySuccess){
          Navigator.of(context).pop(); // Pop the add medicine dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => SuccessDialog(
                title: 'Success',
                subtitle: 'Medicine added successfully',
              ),
            );
          });
        }
        if (state is AddMedicineToInventoryFailure) {
          buildErrorBar(context, state.errorMessage);
        }
      },
      buildWhen: (previous, current) => 
        current is AddMedicineToInventoryLoading || 
        current is AddMedicineToInventoryInitial,
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is AddMedicineToInventoryLoading,
          child: const AddMedicineDialog());
      },
    );
  }
}