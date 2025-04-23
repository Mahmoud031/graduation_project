import 'dart:convert';

import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/services/shared_preferences_singleton.dart';
import 'package:graduation_project/features/auth/data/models/ngo_model.dart';
import 'package:graduation_project/features/auth/data/models/user_model.dart';
import 'package:graduation_project/features/auth/domain/entities/ngo_entity.dart';
import 'package:graduation_project/features/auth/domain/entities/user_entity.dart';

UserEntity getUser() {
  var jsonString = Prefs.getString(kUserData);
  var userEntity = UserModel.fromJson(jsonDecode(jsonString));
  return userEntity;
}
NgoEntity getNgo() {
  var jsonString = Prefs.getString(kNgoData);
  var ngoEntity = NgoModel.fromJson(jsonDecode(jsonString));
  return ngoEntity;
}
