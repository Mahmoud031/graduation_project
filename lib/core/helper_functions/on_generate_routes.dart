import 'package:flutter/material.dart';
import 'package:graduation_project/features/auth/presentation/views/sign_in_view.dart';
import 'package:graduation_project/features/auth/presentation/views/sign_up_ngo_view.dart';
import 'package:graduation_project/features/auth/presentation/views/sign_up_view.dart';
import 'package:graduation_project/features/donor_features/add_medicine/presentation/views/add_medicine_view.dart';
import 'package:graduation_project/features/donor_features/donation_guide/presentation/views/donation_guide_view.dart';
import 'package:graduation_project/features/donor_features/find_ngo/presentation/views/find_ngo_view.dart';
import 'package:graduation_project/features/donor_features/home/presentation/views/home_view.dart';
import 'package:graduation_project/features/ngo_features/Donations/presentation/views/ngo_donations_view.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/views/medicine_inventory_view.dart';
import 'package:graduation_project/features/ngo_features/ngo_home/presentation/views/ngo_home_view.dart';
import 'package:graduation_project/features/donor_features/support_center/presentation/views/contact_support_view.dart';
import 'package:graduation_project/features/donor_features/support_center/presentation/views/support_center_view.dart';
import 'package:graduation_project/features/donor_features/view_transaction/presentation/views/my_donations_view.dart';
import 'package:graduation_project/features/ngo_features/reports/presentation/views/reports_view.dart';
import 'package:graduation_project/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:graduation_project/features/profile/presentation/views/profile_view.dart';
import 'package:graduation_project/features/splash/presentation/views/splash_view.dart';

import '../../features/ngo_features/Donation_Management/presentation/views/donation_management_view.dart';

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
    case FindNgoView.routeName:
      return MaterialPageRoute(builder: (_) => const FindNgoView());
    case AddMedicineView.routeName:
      final String ngoName = settings.arguments as String? ?? '';
      return MaterialPageRoute(
          builder: (_) => AddMedicineView(ngoName: ngoName));
    case MyDonationsView.routeName:
      return MaterialPageRoute(builder: (_) => const MyDonationsView());
    case HomeView.routeName:
      return MaterialPageRoute(builder: (_) => const HomeView());
    case SupportCenterView.routeName:
      return MaterialPageRoute(builder: (_) => const SupportCenterView());
    case ContactSupportView.routeName:
      return MaterialPageRoute(builder: (_) => const ContactSupportView());
    case DonationGuideView.routeName:
      return MaterialPageRoute(builder: (_) => const DonationGuideView());
    case NgoHomeView.routeName:
      return MaterialPageRoute(builder: (_) => const NgoHomeView());
    case NgoDonationsView.routeName:
      return MaterialPageRoute(builder: (_) => const NgoDonationsView());
    case DonationManagementView.routeName:
      return MaterialPageRoute(builder: (_) => const DonationManagementView());
    case MedicineInventoryView.routeName:
      return MaterialPageRoute(builder: (_) => const MedicineInventoryView());
    case ReportsView.routeName:
      return MaterialPageRoute(builder: (_) => const ReportsView());
    case ProfileView.routeName:
      return MaterialPageRoute(builder: (_) => const ProfileView());
    default:
      return MaterialPageRoute(builder: (_) => const SplashView());
  }
}
