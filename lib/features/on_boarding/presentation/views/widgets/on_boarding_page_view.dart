import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_images.dart';

import 'page_view_item.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      PageView(children: [
        PageViewItem(
          image: AppImages.onBoardingPageOne,
          title: 'Online Unused Medicine Donation for NGOs',
        ),
        PageViewItem(
          image: AppImages.onBoardingPageTwo,
          title: 'Bridging Care Gaps with Medicine Donations',
        ),
        PageViewItem(
          image: AppImages.onBoardingPageThree,
          title: 'Reviving Hope with Unused Medicines',
        ),
        PageViewItem(
          image: AppImages.onBoardingPageFour,
          title: 'Empowering Communities Through Medicine Recycling',
        ),
      ]),
      Positioned(
        bottom: 8,
        left: 145,
        child: DotsIndicator(
          dotsCount: 4,
          decorator: DotsDecorator(
            color: Colors.grey,
            activeColor: Colors.white,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ),
    ]);
  }
}
