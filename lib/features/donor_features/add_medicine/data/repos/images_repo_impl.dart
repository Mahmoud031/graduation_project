import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/core/services/storage_service.dart';
import 'package:graduation_project/core/utils/backend_endpoint.dart';
import 'package:graduation_project/features/donor_features/add_medicine/domain/repos/images_repo.dart';

class ImagesRepoImpl implements ImagesRepo{
  final StorageService storageService;

  ImagesRepoImpl(this.storageService);
  @override
  Future<Either<Failure, String>> uploadImage(File image) async {
    
    try {
      String url = await storageService.uploadFile(image, BackendEndpoint.images); 
      return Right(url);
    }catch (e) {
      return Left(ServerFailure('Failed to upload image'));
    }
  }
 
}