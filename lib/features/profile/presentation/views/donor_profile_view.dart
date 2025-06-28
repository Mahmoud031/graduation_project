import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/cubits/medicine_cubit/medicine_cubit.dart';
import 'package:graduation_project/core/services/database_service.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/core/widgets/custom_side_bar.dart';
import 'package:graduation_project/features/donor_features/add_medicine/data/repos/medicine_repo_impl.dart';

import 'widgets/donor_profile_view_body.dart';

class DonorProfileView extends StatelessWidget {
  const DonorProfileView({super.key});
  static const String routeName = 'donorProfileView';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        
      create: (_) => MedicineCubit(MedicineRepoImpl(getIt<DatabaseService>())),
        child: Scaffold(
          drawer: CustomSideBar(),
          body: DonorProfileViewBody(),
        ),
      ),
    );
  }
}
