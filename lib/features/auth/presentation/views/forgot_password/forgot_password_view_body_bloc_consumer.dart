import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/helper_functions/build_error_bar.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/features/auth/presentation/cubits/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:graduation_project/features/auth/presentation/views/forgot_password/forgot_password_view_body.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ForgotPasswordViewBodyBlocConsumer extends StatelessWidget {
  const ForgotPasswordViewBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: const Icon(Icons.email_outlined,
                  size: 48, color: Colors.blue),
              content: Text(
                'If this email is registered, you will receive a password reset link.',
                textAlign: TextAlign.center,
                style: TextStyles.textstyle25.copyWith(
                  color: Colors.black,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).popUntil((route) => route.isFirst),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
        if (state is ForgotPasswordFailure) {
          buildErrorBar(
            context,
            state.message,
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is ForgotPasswordLoading ? true : false,
          opacity: 0.5,
          child: const ForgotPasswordViewBody(),
        );
      },
    );
  }
}
