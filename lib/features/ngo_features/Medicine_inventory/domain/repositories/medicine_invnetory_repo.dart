import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';

import '../entities/medicine_invnetory_entity.dart';

abstract class MedicineInvnetoryRepo {
  Future<Either<Failure, List<MedicineInvnetoryEntity>>> getMedicineInventory();
  Future<Either<Failure, void>> addMedicineInventory(
      MedicineInvnetoryEntity medicineInvnetoryEntity);
  Future<Either<Failure, void>> updateMedicineInventory(
      MedicineInvnetoryEntity medicineInvnetoryEntity);
  Future<Either<Failure, void>> deleteMedicineInventory(String medicineId);
}