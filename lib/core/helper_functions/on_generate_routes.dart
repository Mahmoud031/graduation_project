import 'package:flutter/material.dart';
import 'package:graduation_project/features/auth/presentation/views/sign_in_view.dart';
import 'package:graduation_project/features/auth/presentation/views/sign_up_ngo_view.dart';
import 'package:graduation_project/features/auth/presentation/views/sign_up_view.dart';
import 'package:graduation_project/features/add_medicine/presentation/views/add_medicine_view.dart';
import 'package:graduation_project/features/home/presentation/views/home_view.dart';
import 'package:graduation_project/features/home/presentation/views/view_transaction_view.dart';
import 'package:graduation_project/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:graduation_project/features/splash/presentation/views/splash_view.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) { 
    case SplashView.routeName:
      return MaterialPageRoute(builder: (_) => const SplashView());
    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (_) => const OnBoardingView());
    case SigninView.routeName:
      return MaterialPageRoute(builder: (_) => const SigninView());
    case SignUpView.routeName:
      return MaterialPageRoute(builder: (_) => const SignUpView());
    case SignUpNgoView.routeName:
      return MaterialPageRoute(builder: (_) => const SignUpNgoView());
    case HomeView.routeName:
      return MaterialPageRoute(builder: (_) => const HomeView());
      case AddMedicineView.routeName:
      return MaterialPageRoute(builder: (_) => const AddMedicineView());
    case ViewTransactionView.routeName:
      return MaterialPageRoute(builder: (_) => const ViewTransactionView());
    default:
      return MaterialPageRoute(builder: (_) => const SplashView());
  }
}
