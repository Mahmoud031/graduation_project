import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';
import 'package:graduation_project/features/auth/presentation/cubits/ngo_signup_cubit/ngo_signup_cubit.dart';
import 'package:graduation_project/features/auth/presentation/views/widgets/signup_ngo_view_body_bloc_consumer.dart';

class SignUpNgoView extends StatelessWidget {
  const SignUpNgoView({super.key});
  static const routeName = 'signUpNgoView';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NgoSignupCubit(
        getIt<AuthRepo>(),
      ),
      child: Scaffold(body: const SignupNgoViewBodyBlocConsumer()),
    );
  }
}
