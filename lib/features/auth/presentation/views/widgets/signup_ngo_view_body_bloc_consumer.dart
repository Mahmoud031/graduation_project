import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/helper_functions/build_error_bar.dart';
import 'package:graduation_project/features/auth/presentation/cubits/ngo_signup_cubit/ngo_signup_cubit.dart';
import 'package:graduation_project/features/auth/presentation/views/sign_in_view.dart';

import 'package:graduation_project/features/auth/presentation/views/widgets/sign_up_ngo_body_view.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupNgoViewBodyBlocConsumer extends StatelessWidget {
  const SignupNgoViewBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocConsumer<NgoSignupCubit, NgoSignupState>(
        listener: (context, state) {
          if (state is NgoSignupFailure) {
            buildErrorBar(context, state.message);
          } else if (state is NgoSignupSuccess) {
            buildErrorBar(context, 'Signup Success');
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pushReplacementNamed(context, SigninView.routeName);
            });
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
              inAsyncCall: state is NgoSignupLoading ? true : false,
              child: const SignUpNgoViewBody());
        },
      );
    });
  }
}
