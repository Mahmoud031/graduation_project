import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/services/firebase_auth_service.dart';
import 'package:graduation_project/core/services/shared_preferences_singleton.dart';
import 'package:graduation_project/core/utils/app_images.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/features/auth/presentation/views/sign_in/sign_in_view.dart';
import 'package:graduation_project/features/donor_features/home/presentation/views/home_view.dart';
import 'package:graduation_project/features/ngo_features/ngo_home/presentation/views/ngo_home_view.dart';
import 'package:graduation_project/features/on_boarding/presentation/views/on_boarding_view.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    _controller.forward();
    executeNavigation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(
            image: AssetImage(AppImages.logo),
            height: 280,
            width: 280,
          ),
          const SizedBox(height: 24),
          SlideTransition(
            position: _offsetAnimation,
            child: Text(
              'PharmaShare',
              style: TextStyles.textstyle34.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void executeNavigation() {
    bool isOnBoardingViewSeen = Prefs.getBool(kIsOnBoardingViewSeen);
    Future.delayed(const Duration(seconds: 3), () {
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
