import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/features/add_medicine/domain/repos/images_repo.dart';

class ImagesRepoImpl implements ImagesRepo{
  @override
  Future<Either<Failure, String>> uploadImage(File image) {
    // TODO: implement uploadImage
    throw UnimplementedError();
  }
 
}