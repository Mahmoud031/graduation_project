import 'package:flutter/material.dart';
import 'widgets/add_medicine_dialog.dart';
import 'widgets/medicine_inventory_view_body.dart';

class MedicineInventoryView extends StatelessWidget {
  const MedicineInventoryView({super.key});
  static const String routeName = 'medicine_inventory_view';

  void _showAddMedicineDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddMedicineDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: MedicineInventoryViewBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddMedicineDialog(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
