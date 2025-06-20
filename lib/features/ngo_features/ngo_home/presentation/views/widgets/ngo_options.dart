import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_images.dart';
import 'package:graduation_project/features/ngo_features/Donation_Management/presentation/views/donation_management_view.dart';
import 'package:graduation_project/features/ngo_features/Donations/presentation/views/ngo_donations_view.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/views/medicine_inventory_view.dart';
import 'package:graduation_project/features/ngo_features/ngo_support_center/presentation/views/ngo_support_center_view.dart';
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
      route: NgoDonationsView.routeName,
    ),
    NgoOption(
      title: 'Medicine Inventory',
      imagePath: AppImages.ngoMedicineInventory,
      color: Colors.orangeAccent,
      route: MedicineInventoryView.routeName,
    ),
    NgoOption(
      title: 'Donation Management',
      imagePath: AppImages.ngoDistributionManagement,
      color: Colors.orangeAccent,
      route: DonationManagementView.routeName,
    ),
    NgoOption(
      title: 'Reports',
      imagePath: AppImages.ngoReports,
      color: Colors.orangeAccent,
      route: ReportsView.routeName,
    ),
    NgoOption(
      title: 'Support Center',
      imagePath: AppImages.ngoSupportCenter,
      color: Colors.orangeAccent,
      route: NgoSupportCenterView.routeName,
    ),
  ];
}
