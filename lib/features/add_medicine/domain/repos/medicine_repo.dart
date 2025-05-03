import 'package:graduation_project/features/add_medicine/domain/entities/add_new_medicine_entity.dart';

abstract class MedicineRepo {
  Future<void> addMedicine(AddNewMedicineEntity addNewMedicineEntity);
}
