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
      getMedicineInventory() async{
    try {
      log('Fetching medicine inventory from Firestore...');
      var data = await databaseService.getData(
          path: BackendEndpoint.getMedicineInventory) as List<Map<String, dynamic>>;
      log('Received data from Firestore: $data');
      if (data.isEmpty) {
        log('No medicine inventory found in Firestore');
        return right([]);
      }
      List<MedicineInvnetoryEntity> medicineInventory = data
          .map((e) => MedicineInvnetoryModel.fromJson(e).toEntity())
          .toList();
      log('Successfully converted ${medicineInventory.length} medicines for NGO');
      return right(medicineInventory);
    } catch (e) {
      log('Error getting medicine inventory: $e');
      return Left(ServerFailure('Failed to get medicine inventory: ${e.toString()}'));
    }
    
  }

  @override
  Future<Either<Failure, void>> updateMedicineInventory(
      MedicineInvnetoryEntity medicineInvnetoryEntity) {
    // TODO: implement updateMedicineInventory
    throw UnimplementedError();
  }
}
