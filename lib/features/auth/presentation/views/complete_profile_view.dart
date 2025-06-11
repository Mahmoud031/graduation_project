import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/helper_functions/build_error_bar.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_images.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/core/widgets/custom_button.dart';
import 'package:graduation_project/core/widgets/custom_text_field.dart';
import 'package:graduation_project/features/auth/domain/entities/user_entity.dart';
import 'package:graduation_project/features/auth/presentation/cubits/complete_profile_cubit/complete_profile_cubit.dart';
import 'package:graduation_project/features/auth/presentation/views/widgets/donor_type_drop_down.dart';
import 'package:graduation_project/features/auth/presentation/views/widgets/member_ngo_toggle.dart';
import 'package:graduation_project/features/auth/presentation/views/widgets/terms_and_conditions.dart';
import 'package:graduation_project/features/donor_features/home/presentation/views/home_view.dart';
import 'package:graduation_project/features/ngo_features/ngo_home/presentation/views/ngo_home_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'dart:developer';

class CompleteProfileView extends StatefulWidget {
  const CompleteProfileView({super.key, required this.userEntity});
  static const routeName = 'completeProfileView';
  final UserEntity userEntity;

  @override
  State<CompleteProfileView> createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteProfileView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String address, type, nationalId, phone;
  late int age;
  bool isMember = true;
  bool isChecked = false;
  String? ngoName;

  @override
  void initState() {
    super.initState();
    ngoName = widget.userEntity.name;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompleteProfileCubit, CompleteProfileState>(
      listener: (context, state) {
        if (state is CompleteProfileSuccess) {
          if (isMember) {
            Navigator.pushReplacementNamed(context, HomeView.routeName);
          } else {
            Navigator.pushReplacementNamed(context, NgoHomeView.routeName);
          }
        } else if (state is CompleteProfileFailure) {
          buildErrorBar(context, state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is CompleteProfileLoading,
          child: Scaffold(
            body: Container(
              decoration:
                  const BoxDecoration(gradient: AppColors.primaryGradient),
              child: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Form(
                      key: formKey,
                      autovalidateMode: autovalidateMode,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Complete Your Profile',
                            style: TextStyles.textstyle34,
                          ),
                          const SizedBox(height: 30),
                          MemebrToggle(
                            isMemberSelected: isMember,
                            onToggle: (value) {
                              setState(() {
                                isMember = value;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xffD9D9D9).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 8),
                                  child: Column(
                                    children: [
                                      Text(
                                        isMember
                                            ? 'Member Registration'
                                            : 'NGO Registration',
                                        style: TextStyles.textstyle25
                                            .copyWith(color: Colors.black),
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        indent:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                        endIndent:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                      ),
                                      const SizedBox(height: 10),
                                      if (isMember) ...[
                                        CustomTextFormField(
                                          hintText: 'Address',
                                          labelText: 'Address',
                                          prefixIcon:
                                              Icons.location_on_outlined,
                                          onSaved: (value) {
                                            address = value!;
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your address';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        DonorTypeDropdown(
                                          onSaved: (value) {
                                            type = value!;
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        CustomTextFormField(
                                          hintText: 'Age',
                                          labelText: 'Age',
                                          prefixIcon: Icons.calendar_today,
                                          textInputType: TextInputType.number,
                                          onSaved: (value) {
                                            age = int.parse(value!);
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your age';
                                            }
                                            if (int.tryParse(value) == null) {
                                              return 'Please enter a valid age';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        CustomTextFormField(
                                          hintText: 'National ID',
                                          labelText: 'National ID',
                                          prefixIcon: Icons.badge,
                                          onSaved: (value) {
                                            nationalId = value!;
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your National ID';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        CustomTextFormField(
                                          hintText: 'Phone',
                                          labelText: 'Phone',
                                          prefixIcon: Icons.phone,
                                          textInputType: TextInputType.phone,
                                          onSaved: (value) {
                                            phone = value!;
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your phone number';
                                            }
                                            return null;
                                          },
                                        ),
                                      ] else ...[
                                        CustomTextFormField(
                                          hintText: 'Enter Ngo Name',
                                          labelText: 'Ngo Name',
                                          prefixIcon: Icons.person,
                                          initialValue: ngoName,
                                          onSaved: (value) {
                                            ngoName = value;
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter NGO Name';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        CustomTextFormField(
                                          hintText: 'Enter Email',
                                          labelText: 'Email',
                                          prefixIcon: Icons.email,
                                          textInputType:
                                              TextInputType.emailAddress,
                                          initialValue: widget.userEntity.email,
                                          enabled: false,
                                        ),
                                        const SizedBox(height: 10),
                                        CustomTextFormField(
                                          hintText: 'Enter phone number',
                                          labelText: 'Contact',
                                          prefixIcon: Icons.phone,
                                          textInputType: TextInputType.phone,
                                          onSaved: (value) {
                                            phone = value!;
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your phone number';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        CustomTextFormField(
                                          hintText: 'Ngo id',
                                          labelText: 'Enter Ngo id',
                                          prefixIcon: Icons.badge,
                                          onSaved: (value) {
                                            nationalId = value!;
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your NGO ID';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        CustomTextFormField(
                                          hintText: 'Enter Address',
                                          labelText: 'Address',
                                          prefixIcon:
                                              Icons.location_on_outlined,
                                          onSaved: (value) {
                                            address = value!;
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your address';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                      const SizedBox(height: 10),
                                      TermsAndConditions(
                                        onChanged: (value) {
                                          setState(() {
                                            isChecked = value;
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      CustomButton(
                                        text: 'Complete Profile',
                                        size: Size(
                                            MediaQuery.of(context).size.width *
                                                0.55,
                                            MediaQuery.of(context).size.height *
                                                0.06),
                                        onPressed: () {
                                          if (!isChecked) {
                                            buildErrorBar(context,
                                                'Please accept the terms and conditions');
                                            return;
                                          }
                                          if (formKey.currentState!
                                              .validate()) {
                                            formKey.currentState!.save();
                                            log('NGO Name: $ngoName, Address: $address, National ID: $nationalId, Phone: $phone');
                                            context
                                                .read<CompleteProfileCubit>()
                                                .completeProfile(
                                                  uId: widget.userEntity.uId,
                                                  email:
                                                      widget.userEntity.email,
                                                  name: isMember
                                                      ? widget.userEntity.name
                                                      : ngoName!,
                                                  address: address,
                                                  type: isMember ? type : 'NGO',
                                                  age: isMember ? age : 0,
                                                  nationalId: nationalId,
                                                  phone: phone,
                                                  isMember: isMember,
                                                );
                                          } else {
                                            autovalidateMode =
                                                AutovalidateMode.always;
                                            setState(() {});
                                          }
                                        },
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
