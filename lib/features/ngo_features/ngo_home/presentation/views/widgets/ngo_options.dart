import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_images.dart';
import 'package:graduation_project/features/ngo_features/Donation_Management/presentation/views/donation_management_view.dart';
import 'package:graduation_project/features/ngo_features/Donations/presentation/views/ngo_donations_view.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/views/medicine_inventory_view.dart';
import 'package:graduation_project/features/ngo_features/medicine_requests/presentation/views/ngo_requests_list_view.dart';
import 'package:graduation_project/features/ngo_features/ngo_support_center/presentation/views/ngo_support_center_view.dart';
import 'package:graduation_project/features/ngo_features/reports/presentation/views/reports_view.dart';
import 'package:graduation_project/features/chat/presentation/views/chat_list_view.dart';
import 'package:graduation_project/features/chatbot/presentation/views/chatbot_view.dart';

import '../../../../medicine_requests/presentation/views/ngo_medicine_request_view.dart';

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
      color: Color(0xFFEC8F5E),
      route: NgoDonationsView.routeName,
    ),
    NgoOption(
      title: 'Medicine Inventory',
      imagePath: AppImages.ngoMedicineInventory,
      color: Color(0xFF9F8772),
      route: MedicineInventoryView.routeName,
    ),
    NgoOption(
      title: 'Donation Management',
      imagePath: AppImages.ngoDistributionManagement,
      color: Color(0xFF9F8772),
      route: DonationManagementView.routeName,
    ),
    NgoOption(
      title: 'Request Medicine',
      imagePath: AppImages.requestMedicineNgo,
      color: Color(0xFF4CAF50),
      route: NgoMedicineRequestView.routeName,
    ),
    NgoOption(
      title: 'My Requests',
      imagePath: AppImages.medicineRequestsNgo,
      color: Color(0xFF1976D2),
      route: NgoRequestsListView.routeName,
    ),
    NgoOption(
      title: 'Reports',
      imagePath: AppImages.ngoReports,
      color: Color(0xFFF3B664),
      route: ReportsView.routeName,
    ),
    NgoOption(
      title: 'Support Center',
      imagePath: AppImages.ngoSupportCenter,
      color: Color(0xFFF3B664),
      route: NgoSupportCenterView.routeName,
    ),
    NgoOption(
      title: 'Chat',
      imagePath: AppImages.chat,
      color: Colors.blue,
      route: ChatListView.routeName,
    ),
    NgoOption(
      title: 'AI Assistant',
      imagePath: AppImages.aiAssistant,
      color: Colors.indigo,
      route: ChatbotView.routeName,
    ),
  ];
}
