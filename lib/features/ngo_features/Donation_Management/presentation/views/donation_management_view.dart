import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/cubits/medicine_cubit/medicine_cubit.dart';
import 'package:graduation_project/core/services/database_service.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/features/donor_features/add_medicine/data/repos/medicine_repo_impl.dart';
import 'package:graduation_project/features/donor_features/add_medicine/domain/repos/medicine_repo.dart';

import 'widgets/donation_management_view_body.dart';

class DonationManagementView extends StatelessWidget {
  const DonationManagementView({super.key});
  static const String routeName = 'donation_management_view';
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedicineCubit(
        MedicineRepoImpl(getIt<DatabaseService>()),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: const DonationManagementViewBody(),
        ),
      ),
    );
  }
}
