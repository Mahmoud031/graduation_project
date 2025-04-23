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
  factory NgoModel.fromJson(Map<String, dynamic> json) {
    return NgoModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      ngoId: json['ngoId'],
      address: json['address'],
      uId: json['uId'], // Ensure this is included in the JSON
    );
  }
  factory NgoModel.fromEntity(NgoEntity ngo) {
    return NgoModel(
      name: ngo.name,
      email: ngo.email,
      phone: ngo.phone,
      ngoId: ngo.ngoId,
      address: ngo.address,
      uId: ngo.uId, // Ensure this is included in the JSON
    );
  }
  toMap() {
    return {
      'uId': uId,
      'name': name,
      'email': email,
      'phone': phone,
      'ngoId': ngoId,
      'address': address,
    };
  }
}
