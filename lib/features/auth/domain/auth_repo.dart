import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      String email, String password, String name, String phone, String nationalId, String address, String type ,int age);
}
