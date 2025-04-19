import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/helper_functions/build_error_bar.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_images.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/core/widgets/custom_button.dart';
import 'package:graduation_project/core/widgets/custom_text_field.dart';
import 'package:graduation_project/core/widgets/password_field.dart';
import 'package:graduation_project/features/auth/presentation/cubits/ngo_signup_cubit/ngo_signup_cubit.dart';
import 'package:graduation_project/features/auth/presentation/views/login_view.dart';
import 'package:graduation_project/features/auth/presentation/views/widgets/memer_ngo_toggle.dart';
import 'package:graduation_project/features/auth/presentation/views/widgets/terms_and_conditions.dart';

class SignUpNgoViewBody extends StatefulWidget {
  const SignUpNgoViewBody({super.key});

  @override
  State<SignUpNgoViewBody> createState() => _SignUpNgoViewBodyState();
}

class _SignUpNgoViewBodyState extends State<SignUpNgoViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email, password, name, phone, ngoId, address;
  late bool isChecked = false;
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
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, LoginView.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?',
                          style: TextStyles.textstyle14
                              .copyWith(color: Colors.black)),
                      SizedBox(
                        width: 4,
                      ),
                      Text('Sign in',
                          style: TextStyles.textstyle14
                              .copyWith(color: Color(0xFF4285F4))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 33,
                ),
                MemebrToggle(
                  isMemberSelected: false,
                ),
                const SizedBox(height: 20),
                Stack(clipBehavior: Clip.none, children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffD9D9D9).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8),
                      child: Form(
                        key: formKey,
                        autovalidateMode: autovalidateMode,
                        child: Column(
                          children: [
                            Text('Ngo Registration',
                                style: TextStyles.textstyle25.copyWith(
                                  color: Colors.black,
                                )),
                            Divider(
                              color: Colors.black,
                              indent: MediaQuery.of(context).size.width * 0.1,
                              endIndent:
                                  MediaQuery.of(context).size.width * 0.1,
                            ),
                            const SizedBox(height: 10),
                            CustomTextFormField(
                              onSaved: (value) {
                                name = value!;
                              },
                              hintText: 'Enter Ngo Name',
                              labelText: 'Ngo Name',
                              prefixIcon: Icons.person,
                            ),
                            const SizedBox(height: 10),
                            CustomTextFormField(
                              onSaved: (value) {
                                email = value!;
                              },
                              hintText: 'Enter Email',
                              labelText: 'Email',
                              prefixIcon: Icons.email,
                            ),
                            const SizedBox(height: 10),
                            CustomTextFormField(
                              onSaved: (value) {
                                phone = value!;
                              },
                              hintText: 'Enter phone number',
                              labelText: 'Contact',
                              prefixIcon: Icons.phone,
                            ),
                            const SizedBox(height: 10),
                            CustomTextFormField(
                              onSaved: (value) {
                                ngoId = value!;
                              },
                              hintText: 'Ngo id',
                              labelText: 'Enter Ngo id',
                              prefixIcon: Icons.badge,
                            ),
                            const SizedBox(height: 10),
                            PasswordField(
                              onSaved: (value) {
                                password = value!;
                              },
                              labelText: 'Password',
                              hintText: 'Enter Password',
                            ),
                            const SizedBox(height: 10),
                            PasswordField(
                             
                              labelText: 'confirm Password',
                              hintText: 'confirm Password',
                            ),
                            const SizedBox(height: 10),
                            CustomTextFormField(
                              onSaved: (value) {
                                address = value!;
                              },
                              hintText: 'Enter Address',
                              labelText: 'Address',
                              prefixIcon: Icons.location_on_outlined,
                            ),
                            const SizedBox(height: 10),
                            TermsAndConditions(
                               onChanged: (value) {
    isChecked = value;
  },
                            ),
                            const SizedBox(height: 10),
                            CustomButton(
                              text: "Sign Up",
                              size: Size(
                                  MediaQuery.of(context).size.width * 0.55,
                                  MediaQuery.of(context).size.height * 0.06),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  if (isChecked) {
                                    context
                                        .read<NgoSignupCubit>()
                                        .createNgoWithEmailAndPassword(
                                          email: email,
                                          password: password,
                                          name: name,
                                          phone: phone,
                                          ngoId: ngoId,
                                          address: address,
                                        );
                                  } else {
                                    buildErrorBar(context,
                                        'Please accept the terms and conditions');
                                  }
                                } else {
                                  setState(() {
                                    autovalidateMode = AutovalidateMode.always;
                                  });
                                }
                              },
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
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
