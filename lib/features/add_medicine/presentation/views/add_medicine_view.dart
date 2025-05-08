import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/core/widgets/custom_side_bar.dart';
import 'package:graduation_project/features/add_medicine/domain/repos/medicine_repo.dart';
import 'package:graduation_project/features/find_ngo/presentation/views/widgets/bottom_navigation_bar_widget/custom_bottom_navigation_bar.dart';
import '../../domain/repos/images_repo.dart';
import '../manager/add_medicine_cubit/add_medicine_cubit.dart';
import 'widgets/add_new_medicine_view_body_bloc_consumer.dart';

class AddMedicineView extends StatelessWidget {
  const AddMedicineView({super.key});
  static const String routeName = 'add_medicine_view';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => AddMedicineCubit(
          getIt.get<ImagesRepo>(),
          getIt.get<MedicineRepo>(),
        ),
        child: Scaffold(
          bottomNavigationBar: CustomBottomNavigationBar(),
          backgroundColor: Color(0xFFC2E1E3),
          drawer: const CustomSideBar(),
          body: AddNewMedicineViewBodyBlocConsumer(),
        ),
      ),
    );
  }
}
