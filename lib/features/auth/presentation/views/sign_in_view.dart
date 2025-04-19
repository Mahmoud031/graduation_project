import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';

import '../cubits/sign_in_cubit/signin_cubit.dart';
import 'widgets/sign_in_view_body.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});
  static const routeName = 'login';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocProvider(
      create: (context) => SigninCubit(getIt.get<AuthRepo>()),
      child: Scaffold(
          backgroundColor: const Color(0xff081720), body: SigninViewBody()),
    ));
  }
}
