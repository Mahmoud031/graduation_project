import 'package:flutter/material.dart';
import 'package:graduation_project/core/widgets/custom_side_bar.dart';

import 'widgets/custom_bottom_navigation_bar.dart';
import 'widgets/view_transaction_view_body.dart';

class ViewTransactionView extends StatelessWidget {
  const ViewTransactionView({super.key});
  static const String routeName = 'view_transaction_view';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CustomBottomNavigationBar(),
        backgroundColor: Color(0xFFC2E1E3),
        drawer: const CustomSideBar(),
        body: ViewTransactionViewBody(),
      ),
    );
  }
}