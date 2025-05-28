import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import 'package:graduation_project/core/services/database_service.dart';
import 'package:graduation_project/core/utils/backend_endpoint.dart';
import 'package:graduation_project/features/donor_features/add_medicine/domain/entities/medicine_entity.dart';


import '../../domain/repos/medicine_repo.dart';
import '../models/medicine_model.dart';

class MedicineRepoImpl implements MedicineRepo {
  final DatabaseService databaseService;

  MedicineRepoImpl(this.databaseService);

  @override
  Future<Either<Failure, void>> addMedicine(
      MedicineEntity addNewMedicineEntity) async {
    try {
      await databaseService.addData(
          path: BackendEndpoint.addMedicine,
          data: MedicineModel.fromEntity(addNewMedicineEntity).toJson());
      return Right(null);
    } catch (e) {
      log('Error adding medicine: $e');
      return Left(ServerFailure('Failed to add medicine: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<MedicineEntity>>> getMedicine() async {
    try {
      log('Fetching medicines from Firestore...');
      var data = await databaseService.getData(
          path: BackendEndpoint.getMedicine) as List<Map<String, dynamic>>;
      
      log('Received data from Firestore: $data');
      
      if (data.isEmpty) {
        log('No medicines found in Firestore');
        return right([]);
      }

      // Get current user's ID
      final currentUser = getUser();
      
      // Filter medicines by current user's ID
      List<MedicineEntity> medicine = data
          .where((e) => e['userId'] == currentUser.uId)
          .map((e) {
            try {
              // Add the document ID to the data
              e['id'] = e['documentId'] ?? e['id'];
              return MedicineModel.fromJson(e).toEntity();
            } catch (e) {
              log('Error converting medicine data: $e');
              rethrow;
            }
          })
          .toList();
 
      log('Successfully converted ${medicine.length} medicines');
      return right(medicine);
    } catch (e) {
      log('Error getting medicines: $e');
      return left(ServerFailure('Failed to get medicines: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<MedicineEntity>>> getMedicineByNgoUId(String ngoUId) async {
    try {
      log('Fetching medicines for NGO from Firestore...');
      var data = await databaseService.getData(
          path: BackendEndpoint.getMedicine) as List<Map<String, dynamic>>;
      
      log('Received data from Firestore: $data');
      
      if (data.isEmpty) {
        log('No medicines found in Firestore');
        return right([]);
      }
      
      // Filter medicines by NGO UID
      List<MedicineEntity> medicine = data
          .where((e) => e['ngoUId'] == ngoUId)
          .map((e) {
            try {
              // Add the document ID to the data
              e['id'] = e['documentId'] ?? e['id'];
              return MedicineModel.fromJson(e).toEntity();
            } catch (e) {
              log('Error converting medicine data: $e');
              rethrow;
            }
          })
          .toList();
 
      log('Successfully converted ${medicine.length} medicines for NGO');
      return right(medicine);
    } catch (e) {
      log('Error getting medicines for NGO: $e');
      return left(ServerFailure('Failed to get medicines for NGO: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> updateMedicineStatus(String medicineId, String status) async {
    try {
      log('Updating medicine status for ID: $medicineId with status: $status');
      await databaseService.updateData(
        path: BackendEndpoint.getMedicine,
        documentId: medicineId,
        data: {'status': status},
      );
      log('Successfully updated medicine status');
      return Right(null);
    } catch (e) {
      log('Error updating medicine status: $e');
      return Left(ServerFailure('Failed to update medicine status: ${e.toString()}'));
    }
  }

  @override
  Stream<List<MedicineEntity>> getMedicineByNgoUIdStream(String ngoUId) {
    return FirebaseFirestore.instance
      .collection(BackendEndpoint.getMedicine)
      .where('ngoUId', isEqualTo: ngoUId)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return MedicineModel.fromJson(data).toEntity();
      }).toList());
  }

  @override
  Stream<List<MedicineEntity>> getMedicineByUserIdStream(String userId) {
    return FirebaseFirestore.instance
      .collection(BackendEndpoint.getMedicine)
      .where('userId', isEqualTo: userId)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return MedicineModel.fromJson(data).toEntity();
      }).toList());
  }
}
