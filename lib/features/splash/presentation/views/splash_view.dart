import 'package:flutter/material.dart';

import 'widgets/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});
  static const String routeName = 'splash';
  @override 
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff8FC9D2),
      body: SplashViewBody(),
    );
  }
}
