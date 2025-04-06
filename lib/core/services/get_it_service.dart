import 'package:get_it/get_it.dart';
import 'package:graduation_project/features/auth/data/repos/auth_repo_impl.dart';
import 'package:graduation_project/features/auth/domain/auth_repo.dart';

import 'firebase_auth_service.dart';

final getIt = GetIt.instance;
void setup() {
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
getIt.registerSingleton<AuthRepo>(AuthRepoImpl(
  firebaseAuthService: getIt<FirebaseAuthService>(),
));
}