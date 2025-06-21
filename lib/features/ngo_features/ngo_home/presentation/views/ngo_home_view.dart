import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import 'package:graduation_project/core/widgets/custom_home_app_bar.dart';
import 'package:graduation_project/core/cubits/medicine_cubit/medicine_cubit.dart';
import 'package:graduation_project/core/services/database_service.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/features/donor_features/add_medicine/data/repos/medicine_repo_impl.dart';
import '../../../../profile/presentation/views/ngo_profile_view.dart';
import 'widgets/ngo_home_view_body.dart';

class NgoHomeView extends StatelessWidget {
  const NgoHomeView({super.key});
  static const routeName = 'ngoHomeView';
  @override
  Widget build(BuildContext context) {
    final ngo = getNgo();
    return BlocProvider(
      create: (_) => MedicineCubit(MedicineRepoImpl(getIt<DatabaseService>())),
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF3E0),
        appBar: CustomHomeAppBar(
          onPressed: () {
            Navigator.pushNamed(context, NgoProfileView.routeName);
          },
          title: 'Welcome, ${ngo.name}',
        ),
        body: const SafeArea(
          child: NgoHomeViewBody(),
        ),
      ),
    );
  }
}
