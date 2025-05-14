import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/features/add_medicine/domain/entities/medicine_entity.dart';

abstract class MedicineRepo {
  Future<Either<Failure, void>> addMedicine(
      MedicineEntity addNewMedicineEntity);

  Future<Either<Failure, List<MedicineEntity>>> getMedicine();
}
