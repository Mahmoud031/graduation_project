import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/cubits/medicine_cubit/medicine_cubit.dart';
import 'package:graduation_project/core/helper_functions/get_dummy_medicine.dart';
import 'package:graduation_project/core/widgets/custom_error.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:graduation_project/features/donor_features/add_medicine/domain/entities/medicine_entity.dart';
import 'my_donation_card.dart';

class MyDonationCardViewBlocBuilder extends StatelessWidget {
  final List<MedicineEntity> medicines;

  const MyDonationCardViewBlocBuilder({
    super.key,
    required this.medicines,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicineCubit, MedicineState>(
      builder: (context, state) {
        if (state is MedicineSuccess) {
          return MyDonationsCard(
            medicine: medicines,
          );
        } else if (state is MedicineFailure) {
          return CustomError(text: state.errorMessage);
        } else {
          return Skeletonizer(
              child: MyDonationsCard(
            medicine: getDummyMedicineList(),
          ));
        }
      },
    );
  }
}
