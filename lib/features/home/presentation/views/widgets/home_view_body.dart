import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/core/widgets/custom_app_bar.dart';
import 'package:graduation_project/core/widgets/custom_search_text_field.dart';

import 'ngo_info.dart';
import 'ngo_table.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  bool showNgoInfo = false;

  void toggleNgoInfo() {
    setState(() {
      showNgoInfo = !showNgoInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomAppBar(title: 'Donate Medicine',),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Text(
            'Search Location to Find Ngo',
            style: TextStyles.textstyle25.copyWith(
              fontSize: MediaQuery.of(context).size.width * 0.06,
              color: Color(0xFF888888),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          CustomSearchTextField(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: NGOTable(onViewPressed: toggleNgoInfo),
          ),
          if (showNgoInfo) ...[
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            NgoInfo(),
          ],
        ],
      ),
    );
  }
}
