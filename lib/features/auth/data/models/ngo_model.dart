import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project/features/auth/domain/entities/ngo_entity.dart';

class NgoModel extends NgoEntity {
  NgoModel(
      {required super.name,
      required super.email,
      required super.phone,
      required super.ngoId,
      required super.address,
      required super.uId});
  factory NgoModel.fromFirebaseUser(User user) {
    return NgoModel(
      uId: user.uid,
      name: user.displayName ?? 'Unknown',
      email: user.email ?? '',
      phone: user.phoneNumber ?? '',
      ngoId: 'Unknown',
      address: 'unKnown',
    );
  }
}
