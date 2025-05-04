import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/core/services/database_service.dart';
import 'package:graduation_project/core/utils/backend_endpoint.dart';
import 'package:graduation_project/features/add_medicine/domain/entities/add_new_medicine_entity.dart';

import '../../domain/repos/medicine_repo.dart';
import '../models/add_new_medicine_model.dart';

class MedicineRepoImpl implements MedicineRepo {
  final DatabaseService databaseService;

  MedicineRepoImpl(this.databaseService);
  @override
  Future<Either<Failure, void>> addMedicine(
      AddNewMedicineEntity addNewMedicineEntity) async {
    try {
      await databaseService.addData(
          path: BackendEndpoint.addMedicine,
          data: AddNewMedicineModel.fromEntity(addNewMedicineEntity).toJson());
      return Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to add medicine'));
    }
  }
}
