import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/cubits/medicine_cubit/medicine_cubit.dart';
import 'package:graduation_project/core/services/database_service.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/features/donor_features/add_medicine/data/repos/medicine_repo_impl.dart';
import '../../../../../core/widgets/custom_home_app_bar.dart';
import 'widgets/ngo_donations_view_body.dart';

class NgoDonationsView extends StatelessWidget {
  const NgoDonationsView({super.key});
  static const String routeName = 'ngo_donations_view';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
      create: (_) => MedicineCubit(MedicineRepoImpl(getIt<DatabaseService>())),
        child: Scaffold(
          appBar: CustomHomeAppBar(title: 'NGO Donations'),
          backgroundColor: Colors.white,
          body: const NgoDonationsViewBody(),
        ),
      ),
    );
  }
}
