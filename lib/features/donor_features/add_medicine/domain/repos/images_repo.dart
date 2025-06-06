import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';

abstract class ImagesRepo {
  Future<Either<Failure,String>> uploadImage(File image);
}