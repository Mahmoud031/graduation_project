import 'package:flutter/material.dart';
import 'package:graduation_project/features/auth/presentation/views/login_view.dart';
import 'package:graduation_project/features/auth/presentation/views/sign_up_ngo_view.dart';
import 'package:graduation_project/features/auth/presentation/views/sign_up_view.dart';
import 'package:graduation_project/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:graduation_project/features/splash/presentation/views/splash_view.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (_) => const SplashView());
    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (_) => const OnBoardingView());
    case LoginView.routeName:
      return MaterialPageRoute(builder: (_) => const LoginView());
    case SignUpView.routeName:
      return MaterialPageRoute(builder: (_) => const SignUpView());
    case SignUpNgoView.routeName:
      return MaterialPageRoute(builder: (_) => const SignUpNgoView());
    default:
      return MaterialPageRoute(builder: (_) => const SplashView());
  }
}