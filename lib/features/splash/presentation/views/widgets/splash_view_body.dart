import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/services/firebase_auth_service.dart';
import 'package:graduation_project/core/services/shared_preferences_singleton.dart';
import 'package:graduation_project/features/auth/presentation/views/sign_in/sign_in_view.dart';
import 'package:graduation_project/features/donor_features/home/presentation/views/home_view.dart';
import 'package:graduation_project/features/ngo_features/ngo_home/presentation/views/ngo_home_view.dart';
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
    bool isOnBoardingViewSeen = Prefs.getBool(kIsOnBoardingViewSeen);
    Future.delayed(const Duration(seconds: 1), () {
      if (isOnBoardingViewSeen) {
        var isLoggedIn = FirebaseAuthService().isLoggedIn();
        if (isLoggedIn) {
          var userData = Prefs.getString(kUserData);
          var ngoData = Prefs.getString(kNgoData);
          
          if (userData.isNotEmpty) {
            Navigator.pushReplacementNamed(context, HomeView.routeName);
          } else if (ngoData.isNotEmpty) {
            Navigator.pushReplacementNamed(context, NgoHomeView.routeName);
          } else {
            Navigator.pushReplacementNamed(context, SigninView.routeName);
          }
        } else {
          Navigator.pushReplacementNamed(context, SigninView.routeName);
        }
      } else {
        Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
      }
    });
  }
}
