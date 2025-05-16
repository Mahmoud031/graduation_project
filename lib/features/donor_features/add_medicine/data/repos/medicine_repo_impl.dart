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
      return Left(ServerFailure('Failed to add medicine'));
    }
  }
  
  @override
  Future<Either<Failure, List<MedicineEntity>>> getMedicine() async {
    try {
  var data = await databaseService.getData(path: BackendEndpoint.getMedicine) 
  as List<Map<String, dynamic>>;
  List<MedicineEntity> medicine = data
      .map((e) => MedicineModel.fromJson(e).toEntity())
      .toList();
  return right(medicine);
}  catch (e) {
  return left(ServerFailure('Failed to get medicine'));
}
   }
}
