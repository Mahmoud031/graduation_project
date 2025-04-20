import 'package:get_it/get_it.dart';
import 'package:graduation_project/core/services/database_service.dart';
import 'package:graduation_project/features/auth/data/repos/auth_repo_impl.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';

import 'firebase_auth_service.dart';
import 'firestore_service.dart';

final getIt = GetIt.instance;
void setupGetit() {
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<DatabaseService>(FirestoreService());
getIt.registerSingleton<AuthRepo>(AuthRepoImpl(
  firebaseAuthService: getIt<FirebaseAuthService>(),
  databaseService: getIt<DatabaseService>(),
));
}