import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/cubit/add_medicine_to_inventory_cubit/add_medicine_to_inventory_cubit.dart';
import '../../domain/repositories/medicine_invnetory_repo.dart';
import 'widgets/add_medicine_dialog.dart';
import 'widgets/add_medicine_dialog_bloc_consumer.dart';
import 'widgets/medicine_inventory_view_body.dart';

class MedicineInventoryView extends StatelessWidget {
  const MedicineInventoryView({super.key});
  static const String routeName = 'medicine_inventory_view';

  void _showAddMedicineDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => AddMedicineToInventoryCubit(
          getIt.get<MedicineInvnetoryRepo>(),
        ),
        child: AddMedicineDialogBlocConsumer(),
      ),
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


