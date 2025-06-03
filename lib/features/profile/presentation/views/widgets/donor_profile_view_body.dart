import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/cubits/medicine_cubit/medicine_cubit.dart';
import 'package:graduation_project/core/widgets/custom_app_bar.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import 'package:graduation_project/features/auth/domain/entities/user_entity.dart';
import 'package:graduation_project/features/auth/presentation/cubits/logout_cubit/logout_cubit.dart';
import 'package:graduation_project/features/auth/presentation/views/sign_in_view.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/core/helper_functions/build_error_bar.dart';
import '../edit_donor_profile_view.dart';
import 'edit_profile_button.dart';
import 'profile_header.dart';
import 'statistics_grid.dart';
import 'quick_actions.dart';

class DonorProfileViewBody extends StatefulWidget {
  const DonorProfileViewBody({super.key});

  @override
  State<DonorProfileViewBody> createState() => _DonorProfileViewBodyState();
}

class _DonorProfileViewBodyState extends State<DonorProfileViewBody> {
  @override
  void initState() {
    super.initState();
    final user = getUser();
    context.read<MedicineCubit>().listenToDonorMedicines(user.uId);
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => getIt<LogoutCubit>(),
          child: BlocConsumer<LogoutCubit, LogoutState>(
            listener: (context, state) {
              if (state is LogoutSuccess) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SigninView()),
                  (route) => false,
                );
              } else if (state is LogoutFailure) {
                buildErrorBar(context, state.message);
              }
            },
            builder: (context, state) {
              return AlertDialog(
                title: const Text('Logout'),
                content: const Text('Are you sure you want to log out?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.read<LogoutCubit>().signOut();
                    },
                    child: state is LogoutLoading
                        ? const CircularProgressIndicator()
                        : const Text('Logout'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final UserEntity user = getUser();
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE3F0FF), Color(0xFFF8F6FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(
              title: 'My Profile',
            ),
            const SizedBox(height: 20),
            ProfileHeader(user: user),
            const SizedBox(height: 24),
            const StatisticsGrid(),
            const SizedBox(height: 24),
            const QuickActions(),
            const SizedBox(height: 24),
            EditProfileButton(
              onPressed: () {
                Navigator.pushNamed(context, EditDonorProfileView.routeName);
              },
            ),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () => _showLogoutConfirmationDialog(context),
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
