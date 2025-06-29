import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/features/ngo_features/medicine_requests/domain/entities/medicine_request_entity.dart';

abstract class MedicineRequestRepo {
  Future<Either<Failure, void>> createMedicineRequest(
      MedicineRequestEntity medicineRequestEntity);
  
  Future<Either<Failure, List<MedicineRequestEntity>>> getAllMedicineRequests();
  
  Future<Either<Failure, List<MedicineRequestEntity>>> getMedicineRequestsByNgoUId(String ngoUId);
  
  Future<Either<Failure, void>> updateMedicineRequestStatus(
    String requestId,
    String status, {
    String? fulfilledDonorId,
    String? fulfilledDate,
    String? donorName,
    String? fulfilledQuantity,
    List<Map<String, dynamic>>? donations,
  });
  
  Future<Either<Failure, void>> deleteMedicineRequest(String requestId);
  
  Stream<List<MedicineRequestEntity>> getMedicineRequestsStream();
  
  Stream<List<MedicineRequestEntity>> getMedicineRequestsByNgoUIdStream(String ngoUId);
  
  Future<Either<Failure, void>> updateMedicineRequest(MedicineRequestEntity updatedRequest);
} 