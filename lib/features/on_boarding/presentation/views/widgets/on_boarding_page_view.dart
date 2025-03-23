import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_images.dart';

import 'page_view_item.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return PageView(controller: pageController, children: [
      PageViewItem(
        isVisible: true,
        image: AppImages.onBoardingPageOne,
        title: 'Online Unused Medicine Donation for NGOs',
        currentPage: 0,
        pageController: pageController,
      ),
      PageViewItem(
        isVisible: true,
        image: AppImages.onBoardingPageTwo,
        title: 'Bridging Care Gaps with Medicine Donations',
        currentPage: 1,
        pageController: pageController,
      ),
      PageViewItem(
        isVisible: true,
        image: AppImages.onBoardingPageThree,
        title: 'Reviving Hope with Unused Medicines',
        currentPage: 2,
        pageController: pageController,
      ),
      PageViewItem(
        isVisible: false,
        image: AppImages.onBoardingPageFour,
        title: 'Empowering Communities Through Medicine Recycling',
        currentPage: 3,
        pageController: pageController,
      ),
    ]);
  }
}
