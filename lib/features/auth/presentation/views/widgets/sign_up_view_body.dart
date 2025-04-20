import 'package:flutter/material.dart';
import 'package:graduation_project/core/helper_functions/build_error_bar.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_images.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/core/widgets/custom_button.dart';
import 'package:graduation_project/features/auth/presentation/views/widgets/member_form_fields.dart';
import 'package:graduation_project/features/auth/presentation/views/widgets/handlers/member_signup_handler.dart';
import 'package:graduation_project/features/auth/presentation/views/widgets/member_ngo_toggle.dart';
import 'package:graduation_project/features/auth/presentation/views/widgets/sign_in_link.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email, password, name, phone, nationalId, type, address;
  late int age;
  late bool isChecked = false;
  

  void _handleSignUp() {
  if (!formKey.currentState!.validate()) return;
  formKey.currentState!.save();

  if (!isChecked) {
    buildErrorBar(context, 'Please accept the terms and conditions');
    return;
  }

  final handler = MemberSignupHandler(
    context: context,
    formKey: formKey,
    isChecked: isChecked,
    password: password,
    email: email,
    name: name,
    phone: phone,
    nationalId: nationalId,
    address: address,
    type: type,
    age: age,
  );
  handler.handleSignUp();
}


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Create an account',
                  style: TextStyles.textstyle34,
                ),
                const SizedBox(height: 5),
                const SignInLink(),
                const SizedBox(height: 33),
                const MemebrToggle(
                  isMemberSelected: true,
                ),
                const SizedBox(height: 20),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffD9D9D9).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        child: Form(
                          key: formKey,
                          autovalidateMode: autovalidateMode,
                          child: Column(
                            children: [
                              MemberFormFields(
                                onNameSaved: (value) => name = value!,
                                onEmailSaved: (value) => email = value!,
                                onAgeSaved: (value) => age = int.parse(value!),
                                onPhoneSaved: (value) => phone = value!,
                                onNationalIdSaved: (value) => nationalId = value!,
                                onPasswordSaved: (value) => password = value!,
                                onAddressSaved: (value) => address = value!,
                                onTypeSaved: (value) => type = value!,
                                onTermsChanged: (value) => isChecked = value,
                              ),
                              const SizedBox(height: 10),
                              CustomButton(
                                text: "Sign Up",
                                size: Size(
                                    MediaQuery.of(context).size.width * 0.55,
                                    MediaQuery.of(context).size.height * 0.06),
                                onPressed: _handleSignUp,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * -0.04,
                      right: -7,
                      child: Image.asset(
                        AppImages.signUpViewIcon,
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
