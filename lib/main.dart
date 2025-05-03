import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/services/custom_bloc_observer.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/core/services/shared_preferences_singleton.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/helper_functions/on_generate_routes.dart';
import 'features/splash/presentation/views/splash_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
   await Supabase.initialize(
    url: 'https://ifejihadguxqbftqvlfh.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlmZWppaGFkZ3V4cWJmdHF2bGZoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDYxMDU0OTksImV4cCI6MjA2MTY4MTQ5OX0.heW9zSJz15igNJQZRBshGh7T6ycW0lkORQz66phZFKU',
  );
  Bloc.observer = CustomBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Prefs.init();
  setupGetit();
  runApp(const Medics());
}

class Medics extends StatelessWidget {
  const Medics({super.key});

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
