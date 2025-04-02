import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_images.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/core/widgets/custom_button.dart';
import 'package:graduation_project/core/widgets/custom_text_field.dart';
import 'package:graduation_project/features/auth/presentation/views/login_view.dart';
import 'package:graduation_project/features/auth/presentation/views/widgets/terms_and_conditions.dart';

import 'donor_type_drop_down.dart';
import 'memer_ngo_toggle.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

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
                      child: Column(
                        children: [
                          Text('Member Registration',
                              style: TextStyles.textstyle25.copyWith(
                                color: Colors.black,
                              )),
                          Divider(
                            color: Colors.black,
                            indent: MediaQuery.of(context).size.width * 0.1,
                            endIndent: MediaQuery.of(context).size.width * 0.1,
                          ),
                          const SizedBox(height: 10),
                          const CustomTextFormField(
                            hintText: 'Enter Full Name',
                            labelText: 'Name',
                            prefixIcon: Icons.person,
                          ),
                          const SizedBox(height: 10),
                          const CustomTextFormField(
                            hintText: 'Enter Email',
                            labelText: 'Email',
                            prefixIcon: Icons.email,
                          ),
                          const SizedBox(height: 10),
                          const CustomTextFormField(
                            hintText: 'Enter Age',
                            labelText: 'Age',
                            prefixIcon: Icons.calendar_today_rounded,
                          ),
                          const SizedBox(height: 10),
                          const CustomTextFormField(
                            hintText: 'Enter phone number',
                            labelText: 'Contact',
                            prefixIcon: Icons.phone,
                          ),
                          const SizedBox(height: 10),
                          const CustomTextFormField(
                            hintText: 'National id',
                            labelText: 'National id',
                            prefixIcon: Icons.badge,
                          ),
                          const SizedBox(height: 10),
                          const CustomTextFormField(
                            hintText: 'Enter Password',
                            labelText: 'Password',
                            prefixIcon: Icons.lock_outlined,
                            suffixIcon: Icons.visibility_off,
                            obscureText: true,
                          ),
                          const SizedBox(height: 10),
                          const CustomTextFormField(
                            hintText: 'Confirm Password',
                            labelText: 'Confirm Password',
                            prefixIcon: Icons.lock_outlined,
                            suffixIcon: Icons.visibility_off,
                            obscureText: true,
                          ),
                          const SizedBox(height: 10),
                          const CustomTextFormField(
                            hintText: 'Enter Address',
                            labelText: 'Address',
                            prefixIcon: Icons.location_on_outlined,
                          ),
                          const SizedBox(height: 10),
                          DonorTypeDropdown(),
                          const SizedBox(height: 10),
                          TermsAndConditions(),
                          const SizedBox(height: 10),
                          CustomButton(
                            text: "Sign Up",
                            size: Size(MediaQuery.of(context).size.width * 0.55,
                                MediaQuery.of(context).size.height * 0.06),
                            onPressed: () {},
                          ),
                        ],
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
