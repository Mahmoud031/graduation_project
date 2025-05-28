import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/features/donor_features/add_medicine/domain/entities/medicine_entity.dart';

abstract class MedicineRepo {
  Future<Either<Failure, void>> addMedicine(
      MedicineEntity addNewMedicineEntity);

  Future<Either<Failure, List<MedicineEntity>>> getMedicine();
  
  Future<Either<Failure, List<MedicineEntity>>> getMedicineByNgoUId(String ngoUId);

  Future<Either<Failure, void>> updateMedicineStatus(String medicineId, String status);

  Stream<List<MedicineEntity>> getMedicineByNgoUIdStream(String ngoUId);

  Stream<List<MedicineEntity>> getMedicineByUserIdStream(String userId);
}
