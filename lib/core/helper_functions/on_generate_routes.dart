import 'package:flutter/material.dart';
import 'package:graduation_project/features/auth/presentation/views/sign_in_view.dart';
import 'package:graduation_project/features/auth/presentation/views/sign_up_ngo_view.dart';
import 'package:graduation_project/features/auth/presentation/views/sign_up_view.dart';
import 'package:graduation_project/features/donor_features/add_medicine/presentation/views/add_medicine_view.dart';
import 'package:graduation_project/features/donor_features/donation_guide/presentation/views/donation_guide_view.dart';
import 'package:graduation_project/features/donor_features/find_ngo/presentation/views/find_ngo_view.dart';
import 'package:graduation_project/features/donor_features/home/presentation/views/home_view.dart';
import 'package:graduation_project/features/ngo_features/Donations/presentation/views/donations_view.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/views/medicine_inventory_view.dart';
import 'package:graduation_project/features/ngo_features/ngo_home/presentation/views/ngo_home_view.dart';
import 'package:graduation_project/features/donor_features/support_center/presentation/views/contact_support_view.dart';
import 'package:graduation_project/features/donor_features/support_center/presentation/views/support_center_view.dart';
import 'package:graduation_project/features/donor_features/view_transaction/presentation/views/view_transaction_view.dart';
import 'package:graduation_project/features/ngo_features/reports/presentation/views/reports_view.dart';
import 'package:graduation_project/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:graduation_project/features/splash/presentation/views/splash_view.dart';

import '../../features/ngo_features/Distribution_Management/presentation/views/distribution_management_view.dart';

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
      return MaterialPageRoute(builder: (_) => const AddMedicineView());
    case ViewTransactionView.routeName:
      return MaterialPageRoute(builder: (_) => const ViewTransactionView());
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
    case DonationsView.routeName:
      return MaterialPageRoute(builder: (_) => const DonationsView());
    case DistributionManagementView.routeName:
      return MaterialPageRoute(builder: (_) => const DistributionManagementView());
    case MedicineInventoryView.routeName:
      return MaterialPageRoute(builder: (_) => const MedicineInventoryView());
    case ReportsView.routeName:
      return MaterialPageRoute(builder: (_) => const ReportsView());
    default:
      return MaterialPageRoute(builder: (_) => const SplashView());
  }
}
