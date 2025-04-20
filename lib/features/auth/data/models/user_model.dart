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
      // You need to handle this according to your requirements
    );
  }
}