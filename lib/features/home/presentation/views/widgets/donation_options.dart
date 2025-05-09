import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_images.dart';
import 'package:graduation_project/features/add_medicine/presentation/views/add_medicine_view.dart';
import 'package:graduation_project/features/donation_guide/presentation/views/donation_guide_view.dart';
import 'package:graduation_project/features/support_center/presentation/views/support_center_view.dart';
import 'package:graduation_project/features/view_transaction/presentation/views/view_transaction_view.dart';

class DonationOption {
  final String title;
  final String imagePath;
  final Color color;
  final String route;

  const DonationOption({
    required this.title,
    required this.imagePath,
    required this.color,
    required this.route,
  });
}

class DonationOptions {
  static const List<DonationOption> options = [
    DonationOption(
      title: 'Donate Medicine',
      imagePath: AppImages.donateMedicine,
      color: Colors.blue,
      route: AddMedicineView.routeName,
    ),
    DonationOption(
      title: 'Donate Money',
      imagePath: AppImages.donateMoney,
      color: Colors.green,
      route: '/donate-money',
    ),
    DonationOption(
      title: 'My Donations',
      imagePath: AppImages.viewTransaction,
      color: Colors.purple,
      route: ViewTransactionView.routeName,
    ),
    DonationOption(
      title: 'Support Center',
      imagePath: AppImages.supporCenter,
      color: Colors.orange,
      route: SupportCenterView.routeName,
    ),
    DonationOption(
      title: 'Donation Guide',
      imagePath: AppImages.medicineDonationGuide,
      color: Colors.teal,
      route: DonationGuideView.routeName,
    ),
  ];
}
