import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/core/services/database_service.dart';
import 'package:graduation_project/core/utils/backend_endpoint.dart';
import 'package:graduation_project/features/ngo_features/medicine_requests/domain/entities/medicine_request_entity.dart';
import 'package:graduation_project/features/ngo_features/medicine_requests/domain/repos/medicine_request_repo.dart';
import '../models/medicine_request_model.dart';

class MedicineRequestRepoImpl implements MedicineRequestRepo {
  final DatabaseService databaseService;

  MedicineRequestRepoImpl(this.databaseService);

  @override
  Future<Either<Failure, void>> createMedicineRequest(
      MedicineRequestEntity medicineRequestEntity) async {
    try {
      log('Creating medicine request: ${medicineRequestEntity.medicineName}');
      await databaseService.addData(
        path: BackendEndpoint.addMedicineRequest,
        data: MedicineRequestModel.fromEntity(medicineRequestEntity).toJson(),
      );
      log('Successfully created medicine request');
      return Right(null);
    } catch (e) {
      log('Error creating medicine request: $e');
      return Left(ServerFailure('Failed to create medicine request: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<MedicineRequestEntity>>> getAllMedicineRequests() async {
    try {
      log('Fetching all medicine requests from Firestore...');
      var data = await databaseService.getData(
        path: BackendEndpoint.getMedicineRequests,
      ) as List<Map<String, dynamic>>;
      
      log('Received ${data.length} medicine requests from Firestore');
      
      if (data.isEmpty) {
        log('No medicine requests found in Firestore');
        return right([]);
      }

      List<MedicineRequestEntity> requests = data
          .map((e) {
            try {
              e['id'] = e['documentId'] ?? e['id'];
              return MedicineRequestModel.fromJson(e).toEntity();
            } catch (e) {
              log('Error converting medicine request data: $e');
              rethrow;
            }
          })
          .toList();

      // Expiry logic
      final now = DateTime.now();
      for (final req in requests) {
        if (req.expiryDate != null && req.status != 'Fulfilled' && req.status != 'Expired') {
          final expiry = DateTime.tryParse(req.expiryDate!);
          if (expiry != null && expiry.isBefore(now)) {
            await updateMedicineRequestStatus(req.id, 'Expired');
          }
        }
      }

      log('Successfully converted ${requests.length} medicine requests');
      return right(requests);
    } catch (e) {
      log('Error getting medicine requests: $e');
      return left(ServerFailure('Failed to get medicine requests: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<MedicineRequestEntity>>> getMedicineRequestsByNgoUId(String ngoUId) async {
    try {
      log('Fetching medicine requests for NGO: $ngoUId');
      var data = await databaseService.getData(
        path: BackendEndpoint.getMedicineRequests,
      ) as List<Map<String, dynamic>>;
      
      if (data.isEmpty) {
        log('No medicine requests found in Firestore');
        return right([]);
      }

      List<MedicineRequestEntity> requests = data
          .where((e) => e['ngoUId'] == ngoUId)
          .map((e) {
            try {
              e['id'] = e['documentId'] ?? e['id'];
              return MedicineRequestModel.fromJson(e).toEntity();
            } catch (e) {
              log('Error converting medicine request data: $e');
              rethrow;
            }
          })
          .toList();

      log('Successfully converted ${requests.length} medicine requests for NGO');
      return right(requests);
    } catch (e) {
      log('Error getting medicine requests for NGO: $e');
      return left(ServerFailure('Failed to get medicine requests for NGO: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> updateMedicineRequestStatus(
    String requestId,
    String status, {
    String? fulfilledDonorId,
    String? fulfilledDate,
    String? donorName,
    String? fulfilledQuantity,
    List<Map<String, dynamic>>? donations,
  }) async {
    try {
      log('Updating medicine request status for ID: $requestId with status: $status');
      final Map<String, dynamic> data = {'status': status};
      if (fulfilledDonorId != null) {
        data['fulfilledDonorId'] = fulfilledDonorId;
      }
      if (fulfilledDate != null) {
        data['fulfilledDate'] = fulfilledDate;
      }
      if (donorName != null) {
        data['donorName'] = donorName;
      }
      if (fulfilledQuantity != null) {
        data['fulfilledQuantity'] = fulfilledQuantity;
      }
      if (donations != null) {
        data['donations'] = donations;
      }
      await databaseService.updateData(
        path: BackendEndpoint.getMedicineRequests,
        documentId: requestId,
        data: data,
      );
      log('Successfully updated medicine request status');
      return Right(null);
    } catch (e) {
      log('Error updating medicine request status: $e');
      return Left(ServerFailure('Failed to update medicine request status: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMedicineRequest(String requestId) async {
    try {
      log('Deleting medicine request with ID: $requestId');
      await databaseService.deleteData(
        path: BackendEndpoint.getMedicineRequests,
        documentId: requestId,
      );
      log('Successfully deleted medicine request');
      return Right(null);
    } catch (e) {
      log('Error deleting medicine request: $e');
      return Left(ServerFailure('Failed to delete medicine request: ${e.toString()}'));
    }
  }

  @override
  Stream<List<MedicineRequestEntity>> getMedicineRequestsStream() {
    return FirebaseFirestore.instance
        .collection(BackendEndpoint.getMedicineRequests)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              data['id'] = doc.id;
              return MedicineRequestModel.fromJson(data).toEntity();
            }).toList());
  }

  @override
  Stream<List<MedicineRequestEntity>> getMedicineRequestsByNgoUIdStream(String ngoUId) {
    return FirebaseFirestore.instance
        .collection(BackendEndpoint.getMedicineRequests)
        .where('ngoUId', isEqualTo: ngoUId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              data['id'] = doc.id;
              return MedicineRequestModel.fromJson(data).toEntity();
            }).toList());
  }

  @override
  Future<Either<Failure, void>> updateMedicineRequest(MedicineRequestEntity updatedRequest) async {
    try {
      log('Updating medicine request with ID: ${updatedRequest.id}');
      await databaseService.updateData(
        path: BackendEndpoint.getMedicineRequests,
        documentId: updatedRequest.id,
        data: MedicineRequestModel.fromEntity(updatedRequest).toJson(),
      );
      log('Successfully updated medicine request');
      return Right(null);
    } catch (e) {
      log('Error updating medicine request: $e');
      return Left(ServerFailure('Failed to update medicine request: ${e.toString()}'));
    }
  }
} 