import 'package:flutter/material.dart';
import 'package:graduation_project/features/on_boarding/presentation/views/on_boarding_view.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    executeNavigation(); 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Image(
          image: AssetImage('assets/images/logo.png'), height: 295, width: 290),
    );
  }

  void executeNavigation() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
    });
  }
}
