import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';
import 'package:graduation_project/features/auth/presentation/cubits/complete_profile_cubit/complete_profile_cubit.dart';
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
import 'package:graduation_project/features/donor_features/my_donations/presentation/views/my_donations_view.dart';
import 'package:graduation_project/features/ngo_features/reports/presentation/views/reports_view.dart';
import 'package:graduation_project/features/ngo_features/reports/presentation/views/widgets/charts/donor_performance_report.dart';
import 'package:graduation_project/features/ngo_features/reports/presentation/views/widgets/charts/medicine_inventory_donations_report.dart';
import 'package:graduation_project/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:graduation_project/features/profile/presentation/views/donor_profile_view.dart';
import 'package:graduation_project/features/splash/presentation/views/splash_view.dart';
import '../../features/ngo_features/Donation_Management/presentation/views/donation_management_view.dart';
import '../../features/ngo_features/ngo_support_center/presentation/views/ngo_contact_support_view.dart';
import '../../features/ngo_features/ngo_support_center/presentation/views/ngo_support_center_view.dart';
import '../../features/ngo_features/reports/presentation/views/widgets/charts/donations_by_category_report.dart';
import '../../features/profile/presentation/views/edit_donor_profile_view.dart';
import '../../features/profile/presentation/views/edit_ngo_profile_view.dart';
import '../../features/profile/presentation/views/ngo_profile_view.dart';
import 'package:graduation_project/features/auth/domain/entities/user_entity.dart';
import 'package:graduation_project/features/auth/presentation/views/complete_profile_view.dart'; // Import the new view

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
      final Map<String, String> args =
          settings.arguments as Map<String, String>? ?? {};
      final String ngoName = args['ngoName'] ?? '';
      final String ngoUId = args['ngoUId'] ?? '';
      return MaterialPageRoute(
          builder: (_) => AddMedicineView(ngoName: ngoName, ngoUId: ngoUId));
    case MyDonationsView.routeName:
      return MaterialPageRoute(builder: (_) => const MyDonationsView());
    case HomeView.routeName:
      return MaterialPageRoute(builder: (_) => const HomeView());
    case SupportCenterView.routeName:
      return MaterialPageRoute(builder: (_) => const SupportCenterView());
    case ContactSupportView.routeName:
      return MaterialPageRoute(builder: (_) => const ContactSupportView());
    case NgoContactSupportView.routeName:
      return MaterialPageRoute(builder: (_) => const NgoContactSupportView());
    case NgoSupportCenterView.routeName:
      return MaterialPageRoute(builder: (_) => const NgoSupportCenterView());
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
    case DonorProfileView.routeName:
      return MaterialPageRoute(builder: (_) => const DonorProfileView());
    case NgoProfileView.routeName:
      return MaterialPageRoute(builder: (_) => const NgoProfileView());
    case EditNgoProfileView.routeName:
      return MaterialPageRoute(builder: (_) => const EditNgoProfileView());
      case EditDonorProfileView.routeName:
      return MaterialPageRoute(builder: (_) => const EditDonorProfileView());
    case CompleteProfileView.routeName:
      final userEntity = settings.arguments as UserEntity;
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => CompleteProfileCubit(getIt.get<AuthRepo>()),
          child: CompleteProfileView(userEntity: userEntity),
        ),
      );
    case MedicineInventoryDonationsReport.routeName:
      return MaterialPageRoute(
          builder: (_) => const MedicineInventoryDonationsReport());
    case DonationsByCategoryReport.routeName:
      return MaterialPageRoute(
          builder: (_) => const DonationsByCategoryReport());
    case DonorPerformanceReport.routeName:
      return MaterialPageRoute(builder: (_) => const DonorPerformanceReport());

    default:
      return MaterialPageRoute(builder: (_) => const SplashView());
  }
}
