import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/core/widgets/custom_side_bar.dart';
import 'package:graduation_project/features/donor_features/add_medicine/domain/repos/medicine_repo.dart';
import '../../domain/repos/images_repo.dart';
import '../manager/add_medicine_cubit/add_medicine_cubit.dart';
import 'widgets/add_new_medicine_view_body_bloc_consumer.dart';

class AddMedicineView extends StatelessWidget {
  final String ngoName;
  final String ngoUId;
  final String? requestId;
  const AddMedicineView(
      {super.key, required this.ngoName, required this.ngoUId, this.requestId});
  static const String routeName = 'add_medicine_view';
  @override
  Widget build(BuildContext context) {
    if (ngoName.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select an NGO first'),
            backgroundColor: Colors.red,
          ),
        );
        Navigator.pop(context);
      });
      return const SizedBox.shrink();
    }

    return SafeArea(
      child: BlocProvider(
        create: (context) => AddMedicineCubit(
          getIt.get<ImagesRepo>(),
          getIt.get<MedicineRepo>(),
        ),
        child: Scaffold(
          backgroundColor: Color(0xFFC2E1E3),
          drawer: const CustomSideBar(),
          body: AddNewMedicineViewBodyBlocConsumer(
            ngoName: ngoName,
            ngoUId: ngoUId,
            requestId: requestId,
          ),
        ),
      ),
    );
  }
}
