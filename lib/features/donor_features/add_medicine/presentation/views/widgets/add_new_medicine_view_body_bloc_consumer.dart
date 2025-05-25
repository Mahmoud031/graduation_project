import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/helper_functions/build_error_bar.dart';
import 'package:graduation_project/features/donor_features/add_medicine/presentation/manager/add_medicine_cubit/add_medicine_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'add_new_medicine_view_body.dart';

class AddNewMedicineViewBodyBlocConsumer extends StatelessWidget {
  final String ngoName;
  const AddNewMedicineViewBodyBlocConsumer({
    super.key,
    required this.ngoName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddMedicineCubit, AddMedicineState>(
      listener: (context, state) {
        if (state is AddMedicineSuccess) {
          buildErrorBar(context, 'Medicine added successfully');
          Navigator.pop(context);
        }
        if (state is AddMedicineFailure) {
          buildErrorBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
            inAsyncCall: state is AddMedicineLoading,
            child: AddNewMedicineViewBody(ngoName: ngoName),
            );
      },
    );
  }
}
