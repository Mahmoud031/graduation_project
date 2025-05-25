import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';
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

      List<MedicineEntity> medicine = data.map((e) {
        try {
          return MedicineModel.fromJson(e).toEntity();
        } catch (e) {
          log('Error converting medicine data: $e');
          rethrow;
        }
      }).toList();

      log('Successfully converted ${medicine.length} medicines');
      return right(medicine);
    } catch (e) {
      log('Error getting medicines: $e');
      return left(ServerFailure('Failed to get medicines: ${e.toString()}'));
    }
  }
}
