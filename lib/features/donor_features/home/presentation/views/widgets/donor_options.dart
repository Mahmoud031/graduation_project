import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_images.dart';
import 'package:graduation_project/features/donor_features/donation_guide/presentation/views/donation_guide_view.dart';
import 'package:graduation_project/features/donor_features/find_ngo/presentation/views/find_ngo_view.dart';
import 'package:graduation_project/features/donor_features/medicine_requests/presentation/views/medicine_requests_view.dart';
import 'package:graduation_project/features/donor_features/support_center/presentation/views/support_center_view.dart';
import 'package:graduation_project/features/donor_features/my_donations/presentation/views/my_donations_view.dart';
import 'package:graduation_project/features/chat/presentation/views/chat_list_view.dart';

class DonorOption {
  final String title;
  final String imagePath;
  final Color color;
  final String route;

  const DonorOption({
    required this.title,
    required this.imagePath,
    required this.color,
    required this.route,
  });
}

class DonorOptions {
  static const List<DonorOption> options = [
    DonorOption(
      title: 'Donate Medicine',
      imagePath: AppImages.donateMedicine,
      color: Colors.blue,
      route: FindNgoView.routeName,
    ),
    DonorOption(
      title: 'Donate Money',
      imagePath: AppImages.donateMoney,
      color: Colors.green,
      route: '/donate-money',
    ),
    DonorOption(
      title: 'My Donations',
      imagePath: AppImages.viewTransaction,
      color: Colors.purple,
      route: MyDonationsView.routeName,
    ),
    DonorOption(
      title: 'Medicine Requests',
      imagePath: AppImages.medicineRequestsDonor,
      color: Colors.deepOrange,
      route: MedicineRequestsView.routeName,
    ),
    DonorOption(
      title: 'Support Center',
      imagePath: AppImages.supporCenter,
      color: Colors.orange,
      route: SupportCenterView.routeName,
    ),
    DonorOption(
      title: 'Donation Guide',
      imagePath: AppImages.medicineDonationGuide,
      color: Colors.teal,
      route: DonationGuideView.routeName,
    ),
    DonorOption(
      title: 'Chat',
      imagePath: AppImages.medicineDonationGuide,
      color: Colors.blue,
      route: ChatListView.routeName,
    ),
  ];
}
