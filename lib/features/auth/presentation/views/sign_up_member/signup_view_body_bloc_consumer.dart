import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/helper_functions/build_error_bar.dart';
import 'package:graduation_project/features/auth/presentation/cubits/signp_cubit/signup_cubit.dart';
import 'package:graduation_project/features/auth/presentation/views/sign_up_member/sign_up_view_body.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupViewBodyBlocConsumer extends StatelessWidget {
  const SignupViewBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupFailure) {
            buildErrorBar(context, state.message);
          } else if (state is SignupSuccess) {
            buildErrorBar(context, 'Signup Success');
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pop(context);
            });
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
              inAsyncCall: state is SignupLoading ? true : false,
              child: const SignUpViewBody());
        },
      );
    });
  }
}
