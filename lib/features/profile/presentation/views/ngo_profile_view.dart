import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/cubits/medicine_cubit/medicine_cubit.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'widgets/ngo_profile_view_body.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';

class NgoProfileView extends StatelessWidget {
  const NgoProfileView({super.key});
  static const String routeName = 'ngoProfileView';
  @override
  Widget build(BuildContext context) {
    final ngo = getNgo();
    return Scaffold(
      body: BlocProvider(
        create: (_) => MedicineCubit(getIt())..listenToNgoMedicines(ngo.uId),
        child: NgoProfileViewBody(),
      ),
    );
  }
}
