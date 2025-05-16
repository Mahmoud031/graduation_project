import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_images.dart';
import 'package:graduation_project/features/donor_features/find_ngo/presentation/views/find_ngo_view.dart';
import 'package:graduation_project/features/donor_features/support_center/presentation/views/support_center_view.dart';
import 'package:graduation_project/features/donor_features/view_transaction/presentation/views/view_transaction_view.dart';

class NgoOption {
  final String title;
  final String imagePath;
  final Color color;
  final String route;

  const NgoOption({
    required this.title,
    required this.imagePath,
    required this.color,
    required this.route,
  });
}

class NgoOptions {
  static const List<NgoOption> options = [
    NgoOption(
      title: 'Donations',
      imagePath: AppImages.ngoDonations,
      color: Colors.orangeAccent,
      route: FindNgoView.routeName,
    ),
    NgoOption(
      title: 'Medicine Inventory',
      imagePath: AppImages.ngoMedicineInventory,
      color: Colors.orangeAccent,
      route: '/donate-money',
    ),
    NgoOption(
      title: 'Distribution Management',
      imagePath: AppImages.ngoDistributionManagement,
      color: Colors.orangeAccent,
      route: ViewTransactionView.routeName,
    ),
    NgoOption(
      title: 'Reports',
      imagePath: AppImages.ngoReports,
      color: Colors.orangeAccent,
      route: SupportCenterView.routeName,
    ),
  ];
}
