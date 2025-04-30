import 'package:flutter/material.dart';
import 'package:graduation_project/core/widgets/custom_side_bar.dart';
import 'package:graduation_project/features/home/presentation/views/widgets/custom_bottom_navigation_bar.dart';

import 'widgets/add_new_medicine_view_body.dart';

class AddMedicineView extends StatelessWidget {
  const AddMedicineView({super.key});
  static const String routeName = 'add_medicine_view';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CustomBottomNavigationBar(),
        backgroundColor: Color(0xFFC2E1E3),
        drawer: const CustomSideBar(),
        body: AddNewMedicineViewBody(),
      ),
    );
  }
}
