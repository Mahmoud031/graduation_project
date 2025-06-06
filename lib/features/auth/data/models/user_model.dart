import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  UserModel({required super.name, required super.email, required super.age, required super.phone, required super.nationalId, required super.address, required super.type, required super.uId});
  factory UserModel.fromFirebaseUser(User user){
    return UserModel(
      name: user.displayName ?? 'Unknown',
      email: user.email ?? '',
      age: user.metadata.creationTime?.year ?? 0, // Example: using the account creation year as a proxy for age
      nationalId: user.uid, // Example: using user UID as a placeholder for nationalId
      address: 'Unknown', // Default placeholder for address
      type: 'Individual', // Default user type
      phone: user.phoneNumber ?? '', 
      uId: user.uid, // Firebase UID as user ID
      
    );
  }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ,
      email: json['email'] ,
      age: json['age'] ,
      nationalId: json['nationalId'] ,
      address: json['address'] ,
      type: json['type'] ,
      phone: json['phone'] ,
      uId: json['uId'] , // Ensure this is included in the JSON
    );
  }
  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      name: user.name,
      email: user.email,
      age: user.age,
      nationalId: user.nationalId,
      address: user.address,
      type: user.type,
      phone: user.phone,
      uId: user.uId, // Ensure this is included in the JSON
    );
  }
  toMap() {
    return {
      'uId': uId,
      'name': name,
      'email': email,
      'age': age,
      'phone': phone,
      'nationalId': nationalId,
      'address': address,
      'type': type,
    };
  }
}