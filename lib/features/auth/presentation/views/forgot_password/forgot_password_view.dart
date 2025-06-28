import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';
import 'package:graduation_project/features/auth/presentation/cubits/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:graduation_project/features/auth/presentation/views/forgot_password/forgot_password_view_body_bloc_consumer.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});
  static const String routeName = 'forgotPasswordView';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => ForgotPasswordCubit(getIt<AuthRepo>()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Forgot Password'),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: const ForgotPasswordViewBodyBlocConsumer(),
        ),
      ),
    );
  }
}
