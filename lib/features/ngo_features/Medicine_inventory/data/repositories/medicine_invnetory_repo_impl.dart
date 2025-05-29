import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/core/services/database_service.dart';
import 'package:graduation_project/core/utils/backend_endpoint.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/data/models/medicine_invnetory_model.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/domain/entities/medicine_invnetory_entity.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/domain/repositories/medicine_invnetory_repo.dart';

class MedicineInvnetoryRepoImpl implements MedicineInvnetoryRepo {
  final DatabaseService databaseService;

  MedicineInvnetoryRepoImpl({required this.databaseService});
  @override
  Future<Either<Failure, void>> addMedicineInventory(
      MedicineInvnetoryEntity medicineInvnetoryEntity) async {
    try {
      await databaseService.addData(
          path: BackendEndpoint.addMedicinetoInvnetory,
          data: MedicineInvnetoryModel.fromEntity(medicineInvnetoryEntity)
              .toJson());
      return Right(null);
    } catch (e) {
      log('Error adding medicine to inventory: $e');
      return Left(ServerFailure('Failed to add medicine to inventory: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMedicineInventory(String medicineId) {
    // TODO: implement deleteMedicineInventory
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<MedicineInvnetoryEntity>>>
      getMedicineInventory() {
    // TODO: implement getMedicineInventory
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updateMedicineInventory(
      MedicineInvnetoryEntity medicineInvnetoryEntity) {
    // TODO: implement updateMedicineInventory
    throw UnimplementedError();
  }
}
