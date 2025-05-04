import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/features/add_medicine/domain/entities/add_new_medicine_entity.dart';

abstract class MedicineRepo {
  Future<Either<Failure, void>> addMedicine(
      AddNewMedicineEntity addNewMedicineEntity);
}
