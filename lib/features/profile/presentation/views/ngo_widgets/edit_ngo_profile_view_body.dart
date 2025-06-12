import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/helper_functions/build_error_bar.dart';
import 'package:graduation_project/features/auth/domain/entities/ngo_entity.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import 'package:graduation_project/features/profile/presentation/cubits/ngo_profile_edit_cubit.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';
import 'package:graduation_project/features/profile/presentation/views/ngo_widgets/custom_profile_text_field.dart';
import 'package:graduation_project/features/profile/presentation/views/ngo_widgets/password_change_section.dart';
import 'package:graduation_project/features/profile/presentation/views/ngo_widgets/profile_form_actions.dart';

import '../../../../ngo_features/ngo_home/presentation/views/ngo_home_view.dart';

class EditNgoProfileViewBody extends StatefulWidget {
  const EditNgoProfileViewBody({super.key});

  @override
  State<EditNgoProfileViewBody> createState() => _EditNgoProfileViewBodyState();
}

class _EditNgoProfileViewBodyState extends State<EditNgoProfileViewBody> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController ngoIdController;
  late NgoEntity ngo;

  @override
  void initState() {
    super.initState();
    ngo = getNgo();
    nameController = TextEditingController(text: ngo.name);
    phoneController = TextEditingController(text: ngo.phone);
    addressController = TextEditingController(text: ngo.address);
    ngoIdController = TextEditingController(text: ngo.ngoId);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    ngoIdController.dispose();
    super.dispose();
  }

  void onSave(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final updatedNgo = NgoEntity(
        uId: ngo.uId,
        name: nameController.text.trim(),
        email: ngo.email,
        phone: phoneController.text.trim(),
        ngoId: ngoIdController.text.trim(),
        address: addressController.text.trim(),
      );
      context.read<NgoProfileEditCubit>().updateNgoProfile(updatedNgo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NgoProfileEditCubit(getIt()),
      child: BlocConsumer<NgoProfileEditCubit, NgoProfileEditState>(
        listener: (context, state) async {
          if (state is NgoProfileEditSuccess) {
            await getIt<AuthRepo>().saveNgoData(ngo: state.updatedNgo);
            buildErrorBar(context, 'Profile updated successfully');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const NgoHomeView(),
              ),
            );
          } else if (state is NgoProfileEditFailure) {
            buildErrorBar(context, 'Failed to update profile: ${state.error}');
          }
        },
        builder: (context, state) {
          final isLoading = state is NgoProfileEditLoading;
          return isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blue.shade50,
                        Theme.of(context).scaffoldBackgroundColor,
                      ],
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Update your NGO information below',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 32),
                          CustomProfileTextField(
                            controller: nameController,
                            label: 'NGO Name',
                            icon: Icons.business,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter NGO name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomProfileTextField(
                            controller: ngoIdController,
                            label: 'NGO ID',
                            icon: Icons.perm_identity,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter NGO ID';
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
                                return 'Please enter phone number';
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
                                return 'Please enter address';
                              }
                              return null;
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
                );
        },
      ),
    );
  }
}
