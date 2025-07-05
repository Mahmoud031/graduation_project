import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/cubits/medicine_cubit/medicine_cubit.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/core/widgets/custom_side_bar.dart';
import 'package:graduation_project/features/donor_features/add_medicine/domain/repos/medicine_repo.dart';
import 'widgets/my_donations_view_body.dart';

class MyDonationsView extends StatelessWidget {
  const MyDonationsView({super.key});
  static const String routeName = 'view_transaction_view';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        backgroundColor: Color(0xFFC2E1E3),
        drawer: const CustomSideBar(),
        body: BlocProvider(
          create: (context) => MedicineCubit(
            getIt.get<MedicineRepo>()
          ),
          child: MyDonationsViewBody(),
        ),
      ),
    );
  }
}
