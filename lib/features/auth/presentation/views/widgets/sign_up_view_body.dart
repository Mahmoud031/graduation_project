import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/helper_functions/build_error_bar.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_images.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/core/widgets/custom_button.dart';
import 'package:graduation_project/core/widgets/custom_text_field.dart';
import 'package:graduation_project/core/widgets/password_field.dart';
import 'package:graduation_project/features/auth/presentation/cubits/signp_cubit/signup_cubit.dart';
import 'package:graduation_project/features/auth/presentation/views/login_view.dart';
import 'package:graduation_project/features/auth/presentation/views/widgets/terms_and_conditions.dart';
import 'donor_type_drop_down.dart';
import 'memer_ngo_toggle.dart';

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
  late String confirmPasswordInput;

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
                  isMemberSelected: true,
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
                            Text('Member Registration',
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
                              hintText: 'Enter Full Name',
                              labelText: 'Name',
                              prefixIcon: Icons.person,
                              textInputType: TextInputType.name,
                            ),
                            const SizedBox(height: 10),
                            CustomTextFormField(
                              onSaved: (value) {
                                email = value!;
                              },
                              hintText: 'Enter Email',
                              labelText: 'Email',
                              prefixIcon: Icons.email,
                              textInputType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 10),
                            CustomTextFormField(
                              onSaved: (value) {
                                age = int.parse(value!);
                              },
                              hintText: 'Enter Age',
                              labelText: 'Age',
                              prefixIcon: Icons.calendar_today_rounded,
                              textInputType: TextInputType.number,
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
                                nationalId = value!;
                              },
                              hintText: 'National id',
                              labelText: 'National id',
                              prefixIcon: Icons.badge,
                              textInputType: TextInputType.number,
                            ),
                            const SizedBox(height: 10),
                            PasswordField(
                              labelText: 'Password',
                              hintText: 'Enter Password',
                              onSaved: (value) {
                                password = value!;
                              },
                            ),
                            const SizedBox(height: 10),
                            PasswordField(
                              labelText: 'Confirm Password',
                              hintText: 'Confirm Password',
                              onSaved: (value) {
                                confirmPasswordInput = value!;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (formKey.currentState != null &&
                                    formKey.currentState!.validate()) {
                                  // no-op: this avoids recursion
                                }
                                return null;
                              },
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
                            DonorTypeDropdown(
                              onSaved: (value) {
                                type = value!;
                              },
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
                                  if (!isChecked) {
                                    buildErrorBar(context,
                                        'Please accept the terms and conditions');
                                    return;
                                  }
                                  if (confirmPasswordInput != password) {
                                    buildErrorBar(
                                        context, 'Passwords do not match');
                                    return;
                                  }

                                  context
                                      .read<SignupCubit>()
                                      .createUserWithEmailAndPassword(
                                        email: email,
                                        password: password,
                                        name: name,
                                        phone: phone,
                                        nationalId: nationalId,
                                        address: address,
                                        type: type,
                                        age: age,
                                      );
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
