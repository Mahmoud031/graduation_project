import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/services/shared_preferences_singleton.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/features/auth/presentation/views/login_view.dart';

import 'get_started_button.dart';
import 'on_boarding_button.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem(
      {super.key,
      required this.image,
      required this.title,
      required this.isVisible,
      required this.currentPage,
      required this.pageController});
  final String image;
  final String title;
  final bool isVisible;
  final int currentPage;
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(image, fit: BoxFit.fill),
          ),
          Positioned(
            top: 30,
            right: 140,
            left: 20,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
              right: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Visibility(
                  visible: isVisible,
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Prefs.setBool(kIsOnBoardingViewSeen, true);
                            Navigator.of(context)
                                .pushReplacementNamed(LoginView.routeName);
                          },
                          child: Text('Skip', style: TextStyles.textstyle18)),
                      Icon(Icons.arrow_forward_ios, color: Color(0xff2196F3)),
                    ],
                  ),
                ),
              )),
          Visibility(
            visible: currentPage == 3 ? false : true,
            child: Positioned(
              bottom: 30,
              right: 20,
              child: OnBoardingButton(
                text: 'Next',
                icon: Icons.arrow_forward_ios,
                onTap: () {
                  pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ),
          Visibility(
            visible: currentPage == 3 || currentPage == 0 ? false : true,
            child: Positioned(
              bottom: 30,
              left: 20,
              child: OnBoardingButton(
                text: 'Back',
                icon: Icons.arrow_back_ios_new,
                onTap: () {
                  pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ),
          Visibility(
            visible: currentPage == 3 ? true : false,
            child: Positioned(
              bottom: 30,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(LoginView.routeName);
                },
                child: GetStartedButton(
                  text: 'Get Started',
                  icon: Icons.arrow_forward_outlined,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
