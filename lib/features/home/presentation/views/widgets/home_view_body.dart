import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/core/widgets/custom_app_bar.dart';
import 'package:graduation_project/core/widgets/custom_search_text_field.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomAppBar(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Text(
            'Search Location to Find Ngo',
            style: TextStyles.textstyle25.copyWith(
              fontSize: MediaQuery.of(context).size.width * 0.06,
              color: Color(0xFF888888),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          CustomSearchTextField()
        ],
      ),
    );
  }
}
