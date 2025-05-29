import 'package:get_it/get_it.dart';
import 'package:graduation_project/core/services/database_service.dart';
import 'package:graduation_project/core/services/storage_service.dart';
import 'package:graduation_project/core/services/supabase_storage.dart';
import 'package:graduation_project/features/donor_features/add_medicine/data/repos/images_repo_impl.dart';
import 'package:graduation_project/features/donor_features/add_medicine/data/repos/medicine_repo_impl.dart';
import 'package:graduation_project/features/donor_features/add_medicine/domain/repos/images_repo.dart';
import 'package:graduation_project/features/donor_features/add_medicine/domain/repos/medicine_repo.dart';
import 'package:graduation_project/features/auth/data/repos/auth_repo_impl.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';
import 'package:graduation_project/features/donor_features/find_ngo/presentation/cubits/search_ngo_cubit/search_ngo_cubit.dart';
import 'package:graduation_project/features/donor_features/support_center/data/repositories/message_repo_imp.dart';
import 'package:graduation_project/features/donor_features/support_center/domain/repos/message_repo.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/data/repositories/medicine_invnetory_repo_impl.dart';

import '../../features/ngo_features/Medicine_inventory/domain/repositories/medicine_invnetory_repo.dart';
import 'firebase_auth_service.dart';
import 'firestore_service.dart';

final getIt = GetIt.instance;
void setupGetit() {
  getIt.registerSingleton<StorageService>(SupabaseStorageService());
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<DatabaseService>(FirestoreService());
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(
    firebaseAuthService: getIt<FirebaseAuthService>(),
    databaseService: getIt<DatabaseService>(),
  ));
  getIt.registerSingleton<ImagesRepo>(
    ImagesRepoImpl(
      getIt<StorageService>(),
    ),
  );
  getIt.registerSingleton<MedicineRepo>(
    MedicineRepoImpl(
      getIt<DatabaseService>(),
     ),
  );
  getIt.registerFactory<SearchNgoCubit>(
    () => SearchNgoCubit(getIt<DatabaseService>()),
  );
  getIt.registerSingleton<MessageRepo>(
    MessageRepoImp(
      databaseService: getIt<DatabaseService>(),
    ),
  );
  getIt.registerSingleton<MedicineInvnetoryRepo>(
    MedicineInvnetoryRepoImpl(
      databaseService: getIt<DatabaseService>(),
    ),
  );
}
