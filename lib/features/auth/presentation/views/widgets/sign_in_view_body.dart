import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_images.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/core/widgets/custom_button.dart';
import 'package:graduation_project/core/widgets/custom_text_field.dart';
import 'package:graduation_project/core/widgets/dont_have_account.dart';
import 'package:graduation_project/core/widgets/or_divider.dart';
import 'package:graduation_project/core/widgets/password_field.dart';

import 'social_login.dart';

class SigninViewBody extends StatelessWidget {
  const SigninViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                AppImages.loginViewImage,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.35,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  gradient: AppColors.primaryGradient,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 70,
                          ),
                          const CustomTextFormField(
                            labelText: 'Email',
                            hintText: 'Enter your Email',
                            prefixIcon: Icons.person_outline_rounded,
                            textInputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          PasswordField(
                            labelText: 'Password',
                            hintText: 'Enter your Password',
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Forgot Password?',
                                style: TextStyles.textstyle14,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomButton(
                            text: "Sign In",
                            size: Size(MediaQuery.of(context).size.width * 0.6,
                                MediaQuery.of(context).size.height * 0.07),
                            onPressed: () {},
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          const OrDivider(),
                          SizedBox(
                            height: 4,
                          ),
                          Center(
                            child: Text("Sign in with",
                                style: TextStyles.textstyle14
                                    .copyWith(color: Color(0xffCFD4D6))),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          const SocialLogin(),
                          SizedBox(
                            height: 10,
                          ),
                          const DontHaveAccount(),
                        ],
                      ),
                    ),
                    Positioned(
                      top: -35,
                      right: 0,
                      child: Image.asset(
                        AppImages.loginViewIcon,
                        height: 80,
                        width: 65,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
