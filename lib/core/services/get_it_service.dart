import 'package:get_it/get_it.dart';
import 'package:graduation_project/core/services/database_service.dart';
import 'package:graduation_project/core/services/storage_service.dart';
import 'package:graduation_project/core/services/supabase_storage.dart';
import 'package:graduation_project/core/services/gemini_service.dart';
import 'package:graduation_project/features/donor_features/add_medicine/data/repos/images_repo_impl.dart';
import 'package:graduation_project/features/donor_features/add_medicine/data/repos/medicine_repo_impl.dart';
import 'package:graduation_project/features/donor_features/add_medicine/domain/repos/images_repo.dart';
import 'package:graduation_project/features/donor_features/add_medicine/domain/repos/medicine_repo.dart';
import 'package:graduation_project/features/auth/data/repos/auth_repo_impl.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';
import 'package:graduation_project/features/auth/presentation/cubits/logout_cubit/logout_cubit.dart';
import 'package:graduation_project/features/donor_features/find_ngo/presentation/cubits/search_ngo_cubit/search_ngo_cubit.dart';
import 'package:graduation_project/features/donor_features/support_center/data/repositories/message_repo_imp.dart';
import 'package:graduation_project/features/donor_features/support_center/domain/repos/message_repo.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/data/repositories/medicine_invnetory_repo_impl.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/domain/repositories/medicine_invnetory_repo.dart';
import 'package:graduation_project/core/services/firebase_auth_service.dart';
import 'package:graduation_project/core/services/firestore_service.dart';
import 'package:graduation_project/features/ngo_features/medicine_requests/data/repos/medicine_request_repo_impl.dart';
import 'package:graduation_project/features/ngo_features/medicine_requests/domain/repos/medicine_request_repo.dart';
import 'package:graduation_project/features/chat/data/repos/chat_repo_impl.dart';
import 'package:graduation_project/features/chat/domain/repos/chat_repo.dart';
import 'package:graduation_project/features/chat/presentation/cubits/chat_cubit/chat_cubit.dart';
import 'package:graduation_project/features/chat/presentation/cubits/message_cubit/message_cubit.dart';
import 'package:graduation_project/features/chatbot/data/repos/chatbot_repo_impl.dart';
import 'package:graduation_project/features/chatbot/domain/repos/chatbot_repo.dart';

final getIt = GetIt.instance;
void setupGetit() {
  getIt.registerSingleton<StorageService>(SupabaseStorageService());
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<DatabaseService>(FirestoreService());
  getIt.registerSingleton<GeminiService>(GeminiService());
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
  getIt.registerSingleton<MedicineRequestRepo>(
    MedicineRequestRepoImpl(
      getIt<DatabaseService>(),
    ),
  );
  getIt.registerFactory<LogoutCubit>(
    () => LogoutCubit(getIt<AuthRepo>()),
  );
  getIt.registerSingleton<ChatRepo>(
    ChatRepoImpl(
      databaseService: getIt<DatabaseService>(),
    ),
  );
  getIt.registerFactory<ChatCubit>(
    () => ChatCubit(getIt<ChatRepo>()),
  );
  getIt.registerFactory<MessageCubit>(
    () => MessageCubit(getIt<ChatRepo>()),
  );
  getIt.registerSingleton<ChatbotRepo>(
    ChatbotRepoImpl(
      geminiService: getIt<GeminiService>(),
    ),
  );
}
