import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/services/custom_bloc_observer.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/core/services/shared_preferences_singleton.dart';
import 'package:graduation_project/core/services/supabase_storage.dart';
import 'core/helper_functions/on_generate_routes.dart';
import 'features/splash/presentation/views/splash_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SupabaseStorageService.initSupabase();
  await SupabaseStorageService.createBucket('medicine_images');
  Bloc.observer = CustomBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Prefs.init();
  setupGetit();
  runApp(
    const PharmaShare(),
  );
}

class PharmaShare extends StatelessWidget {
  const PharmaShare({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Judson'),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoutes,
      initialRoute: SplashView.routeName,
    );
  }
}
