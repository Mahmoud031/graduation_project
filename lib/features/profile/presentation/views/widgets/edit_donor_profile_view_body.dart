import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/helper_functions/build_error_bar.dart';
import 'package:graduation_project/features/auth/domain/entities/user_entity.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import 'package:graduation_project/features/profile/presentation/cubits/donor_profile_edit_cubit.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';
import 'package:graduation_project/features/profile/presentation/views/ngo_widgets/custom_profile_text_field.dart';
import 'package:graduation_project/features/profile/presentation/views/ngo_widgets/password_change_section.dart';
import 'package:graduation_project/features/profile/presentation/views/ngo_widgets/profile_form_actions.dart';
import 'package:graduation_project/features/donor_features/home/presentation/views/home_view.dart';
import 'package:graduation_project/features/auth/presentation/views/widgets/donor_type_drop_down.dart';

class EditDonorProfileViewBody extends StatefulWidget {
  const EditDonorProfileViewBody({super.key});

  @override
  State<EditDonorProfileViewBody> createState() =>
      _EditDonorProfileViewBodyState();
}

class _EditDonorProfileViewBodyState extends State<EditDonorProfileViewBody> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController nationalIdController;
  late TextEditingController ageController;
  late UserEntity user;
  String? selectedType;

  @override
  void initState() {
    super.initState();
    user = getUser();
    nameController = TextEditingController(text: user.name);
    phoneController = TextEditingController(text: user.phone);
    addressController = TextEditingController(text: user.address);
    nationalIdController = TextEditingController(text: user.nationalId);
    ageController = TextEditingController(text: user.age.toString());
    selectedType = user.type;
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    nationalIdController.dispose();
    ageController.dispose();
    super.dispose();
  }

  void onSave(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final updatedUser = UserEntity(
        uId: user.uId,
        name: nameController.text.trim(),
        email: user.email,
        phone: phoneController.text.trim(),
        nationalId: nationalIdController.text.trim(),
        address: addressController.text.trim(),
        age: int.parse(ageController.text.trim()),
        type: selectedType ?? user.type,
      );
      context.read<DonorProfileEditCubit>().updateDonorProfile(updatedUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DonorProfileEditCubit(getIt()),
      child: BlocConsumer<DonorProfileEditCubit, DonorProfileEditState>(
        listener: (context, state) async {
          if (state is DonorProfileEditSuccess) {
            await getIt<AuthRepo>().saveUserData(user: state.updatedUser);
            buildErrorBar(context, 'Profile updated successfully');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeView(),
              ),
            );
          } else if (state is DonorProfileEditFailure) {
            buildErrorBar(context, 'Failed to update profile: ${state.error}');
          }
        },
        builder: (context, state) {
          final isLoading = state is DonorProfileEditLoading;
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Edit Profile',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context).primaryColor.withOpacity(0.1),
                          Theme.of(context).scaffoldBackgroundColor,
                        ],
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Personal Details',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Update your personal information below',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 32),
                            CustomProfileTextField(
                              controller: nameController,
                              label: 'Full Name',
                              icon: Icons.person,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomProfileTextField(
                              controller: nationalIdController,
                              label: 'National ID',
                              icon: Icons.perm_identity,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your national ID';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomProfileTextField(
                              controller: ageController,
                              label: 'Age',
                              icon: Icons.calendar_today,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your age';
                                }
                                if (int.tryParse(value) == null) {
                                  return 'Please enter a valid age';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomProfileTextField(
                              controller: phoneController,
                              label: 'Phone',
                              icon: Icons.phone,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomProfileTextField(
                              controller: addressController,
                              label: 'Address',
                              icon: Icons.location_on,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            DonorTypeDropdown(
                              initialValue: selectedType,
                              onSaved: (value) {
                                setState(() {
                                  selectedType = value;
                                });
                              },
                            ),
                            const SizedBox(height: 32),
                            const PasswordChangeSection(),
                            const SizedBox(height: 40),
                            ProfileFormActions(
                              isLoading: isLoading,
                              onSave: () => onSave(context),
                              onCancel: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
