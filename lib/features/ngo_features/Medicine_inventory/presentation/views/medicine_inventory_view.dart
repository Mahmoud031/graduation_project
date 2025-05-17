import 'package:flutter/material.dart';

import 'widgets/medicine_inventory_view_body.dart';

class MedicineInventoryView extends StatelessWidget {
  const MedicineInventoryView({super.key});
  static const String routeName = 'medicine_inventory_view';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: MedicineInventoryViewBody()));
  }
}