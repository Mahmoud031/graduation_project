import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/helper_functions/build_error_bar.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/features/auth/presentation/cubits/logout_cubit/logout_cubit.dart';
import 'package:graduation_project/features/auth/presentation/views/change_password/change_password_view.dart';
import 'package:graduation_project/features/auth/presentation/views/sign_in/sign_in_view.dart';
import 'package:graduation_project/features/chatbot/presentation/views/chatbot_view.dart';
import 'package:graduation_project/features/donor_features/donation_guide/presentation/views/donation_guide_view.dart';
import 'package:graduation_project/features/donor_features/find_ngo/presentation/views/find_ngo_view.dart';
import 'package:graduation_project/features/donor_features/medicine_requests/presentation/views/medicine_requests_view.dart';
import 'package:graduation_project/features/donor_features/my_donations/presentation/views/my_donations_view.dart';
import 'package:graduation_project/features/donor_features/support_center/presentation/views/support_center_view.dart';

class CustomSideBar extends StatelessWidget {
  const CustomSideBar({super.key});

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
    final user = getUser();
    return Drawer(
      backgroundColor: const Color(0xFF010E1D),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF010E1D),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.account_circle,
                    size: MediaQuery.of(context).size.width * 0.1,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name, style: TextStyles.textstyle18),
                      Text(user.email, style: TextStyles.textstyle14),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            color: Colors.white24,
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(Icons.volunteer_activism, color: Colors.white),
            title: Text(
              'Donate Medicine',
              style: TextStyles.textstyle18,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, FindNgoView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.history, color: Colors.white),
            title: const Text('My Donations', style: TextStyles.textstyle18),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, MyDonationsView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.medical_services, color: Colors.white),
            title:
                const Text('Medicine Requests', style: TextStyles.textstyle18),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, MedicineRequestsView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.white),
            title: const Text('Change Password', style: TextStyles.textstyle18),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, ChangePasswordView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.white),
            title: const Text('Donation Guide', style: TextStyles.textstyle18),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, DonationGuideView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat, color: Colors.white),
            title: const Text('Chat with AI', style: TextStyles.textstyle18),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, ChatbotView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.help, color: Colors.white),
            title: const Text('Support Center', style: TextStyles.textstyle18),
            onTap: () {
              Navigator.pop(context);

              Navigator.pushNamed(context, SupportCenterView.routeName);
            },
          ),
          const Divider(
            color: Colors.white24,
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.white),
            title: const Text('log out', style: TextStyles.textstyle18),
            onTap: () {
              _showLogoutConfirmationDialog(context);
            },
          ),
        ],
      ),
    );
  }
}
