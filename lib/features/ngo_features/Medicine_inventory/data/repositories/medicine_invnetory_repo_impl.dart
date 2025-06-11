import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/core/services/database_service.dart';
import 'package:graduation_project/core/utils/backend_endpoint.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/data/models/medicine_invnetory_model.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/domain/entities/medicine_invnetory_entity.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/domain/repositories/medicine_invnetory_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  Future<Either<Failure, void>> deleteMedicineInventory(String medicineId) async{
    try {
      log('Deleting medicine with ID: $medicineId from Firestore...');
      await databaseService.deleteData(
          path: BackendEndpoint.deleteMedicineInventory, documentId: medicineId);
      log('Successfully deleted medicine with ID: $medicineId from Firestore');
      return Right(null);
    } catch (e) {
      log('Error deleting medicine with ID: $medicineId from Firestore: $e');
      return Left(ServerFailure('Failed to delete medicine: ${e.toString()}'));
        }
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
      MedicineInvnetoryEntity medicineInvnetoryEntity) async {
    try {
      if (medicineInvnetoryEntity.documentId == null) {
        return Left(ServerFailure('Document ID is required for update'));
      }
      
      await databaseService.updateData(
        path: BackendEndpoint.updateMedicineInventory,
        documentId: medicineInvnetoryEntity.documentId!,
        data: MedicineInvnetoryModel.fromEntity(medicineInvnetoryEntity).toJson(),
      );
      return Right(null);
    } catch (e) {
      log('Error updating medicine inventory: $e');
      return Left(ServerFailure('Failed to update medicine inventory: ${e.toString()}'));
    }
  }

  @override
  Stream<List<MedicineInvnetoryEntity>> getMedicineInventoryByNgoUIdStream(String ngoUId) {
    return FirebaseFirestore.instance
        .collection(BackendEndpoint.getMedicineInventory)
        .where('ngoUId', isEqualTo: ngoUId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              data['id'] = doc.id;
              data['documentId'] = doc.id;
              return MedicineInvnetoryModel.fromJson(data).toEntity();
            }).toList());
  }
}
