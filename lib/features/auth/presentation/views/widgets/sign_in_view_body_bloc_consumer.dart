import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/helper_functions/build_error_bar.dart';
import 'package:graduation_project/features/auth/domain/entities/ngo_entity.dart';
import 'package:graduation_project/features/auth/domain/entities/user_entity.dart';
import 'package:graduation_project/features/auth/presentation/cubits/sign_in_cubit/signin_cubit.dart';
import 'package:graduation_project/features/auth/presentation/views/widgets/sign_in_view_body.dart';
import 'package:graduation_project/features/home/presentation/views/home_view.dart';
import 'package:graduation_project/features/ngo_home/presentation/views/ngo_home_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SigninViewBodyBlocConsumer extends StatelessWidget {
  const SigninViewBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state is SigninSuccess) {
          // Check the type of entity to determine navigation
          if (state.entity is NgoEntity) {
            Navigator.pushNamed(context, NgoHomeView.routeName);
          } else if (state.entity is UserEntity) {
            Navigator.pushNamed(context, HomeView.routeName);
          }
        }
        if (state is SigninFailure) {
          buildErrorBar(
            context,
            state.message,
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
            inAsyncCall: state is SigninLoading ? true : false,
            opacity: 0.5,
            child: SigninViewBody());
      },
    );
  }
}
