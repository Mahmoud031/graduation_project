import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import 'on_boarding_button.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({super.key, required this.image, required this.title});
  final String image;
  final String title;
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
                child: Row(
                  children: [
                    Text('Skip',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    Icon(Icons.arrow_forward_ios, color: Color(0xff2196F3)),
                  ],
                ),
              )),
          Positioned(
            bottom: 30,
            right: 20,
            child: OnBoardingButton(
              text: 'Next',
              icon: Icons.arrow_forward_ios,
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            child: OnBoardingButton(
              text: 'Back',
              icon: Icons.arrow_back_ios_new,
            ),
          ),
        ],
      ),
    );
  }
}
