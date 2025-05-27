import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/cubits/medicine_cubit/medicine_cubit.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/features/donor_features/add_medicine/domain/repos/medicine_repo.dart';
import 'widgets/ngo_donations_view_body.dart';

class NgoDonationsView extends StatelessWidget {
  const NgoDonationsView({super.key});
  static const String routeName = 'ngo_donations_view';
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedicineCubit(getIt<MedicineRepo>()),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: const NgoDonationsViewBody(),
        ),
      ),
    );
  }
}
