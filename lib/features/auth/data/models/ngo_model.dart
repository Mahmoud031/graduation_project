import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project/features/auth/domain/entities/ngo_entity.dart';


class NgoModel extends NgoEntity{
  NgoModel({required super.name, required super.email, required super.phone, required super.ngoId, required super.address});
    factory NgoModel.fromFirebaseUser(User user) {
      return NgoModel(
        name: user.displayName ?? 'Unknown',
        email: user.email ?? '',
        phone: user.phoneNumber ?? '',
        ngoId: user.uid,
        address: 'unKnown',
      );
    }
  }
