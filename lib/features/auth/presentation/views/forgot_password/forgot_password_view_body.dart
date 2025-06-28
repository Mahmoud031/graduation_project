import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/core/widgets/custom_button.dart';
import 'package:graduation_project/core/widgets/custom_text_field.dart';
import 'package:graduation_project/features/auth/presentation/cubits/forgot_password_cubit/forgot_password_cubit.dart';

class ForgotPasswordViewBody extends StatefulWidget {
  const ForgotPasswordViewBody({super.key});

  @override
  State<ForgotPasswordViewBody> createState() => _ForgotPasswordViewBodyState();
}

class _ForgotPasswordViewBodyState extends State<ForgotPasswordViewBody> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            Text(
                '     Enter your email address below and \n we\'ll send you a link to reset your password.',
                style: TextStyles.textstyle18.copyWith(
                  color: Colors.black,
                )),
            const SizedBox(
              height: 32,
            ),
            CustomTextFormField(
              onSaved: (value) {
                email = value!;
              },
              labelText: 'Email',
              hintText: 'Enter your Email',
              prefixIcon: Icons.email_outlined,
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              text: "Send Email",
              size: Size(MediaQuery.of(context).size.width * 0.6,
                  MediaQuery.of(context).size.height * 0.07),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  context.read<ForgotPasswordCubit>().resetPassword(email);
                } else {
                  autovalidateMode = AutovalidateMode.always;
                  setState(() {});
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
