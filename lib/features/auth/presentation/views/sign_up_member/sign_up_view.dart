import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';
import 'package:graduation_project/features/auth/presentation/cubits/signp_cubit/signup_cubit.dart';
import 'package:graduation_project/features/auth/presentation/views/sign_up_member/signup_view_body_bloc_consumer.dart';


class SignUpView extends StatelessWidget {
  const SignUpView({super.key});
  static const routeName = 'signUp';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(
        getIt<AuthRepo>(),
      ),
      child: Scaffold(
        body: SignupViewBodyBlocConsumer(),
      ),
    );
  }
}

