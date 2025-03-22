import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'on_boarding_page_view.dart';

class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      OnBoardingPageView(),
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
