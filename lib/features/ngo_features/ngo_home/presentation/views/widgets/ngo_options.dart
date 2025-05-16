import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_images.dart';
import 'package:graduation_project/features/donor_features/find_ngo/presentation/views/find_ngo_view.dart';
import 'package:graduation_project/features/donor_features/support_center/presentation/views/support_center_view.dart';
import 'package:graduation_project/features/donor_features/view_transaction/presentation/views/view_transaction_view.dart';
import 'package:graduation_project/features/ngo_features/Distribution_Management/presentation/views/distribution_management_view.dart';
import 'package:graduation_project/features/ngo_features/Donations/presentation/views/donations_view.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/views/medicine_inventory_view.dart';
import 'package:graduation_project/features/ngo_features/reports/presentation/views/reports_view.dart';

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
      route: DonationsView.routeName,
    ),
    NgoOption(
      title: 'Medicine Inventory',
      imagePath: AppImages.ngoMedicineInventory,
      color: Colors.orangeAccent,
      route: MedicineInventoryView.routeName,
    ),
    NgoOption(
      title: 'Distribution Management',
      imagePath: AppImages.ngoDistributionManagement,
      color: Colors.orangeAccent,
      route: DistributionManagementView.routeName,
    ),
    NgoOption(
      title: 'Reports',
      imagePath: AppImages.ngoReports,
      color: Colors.orangeAccent,
      route: ReportsView.routeName,
    ),
  ];
}
