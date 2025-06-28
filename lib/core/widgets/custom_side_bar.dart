import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/helper_functions/build_error_bar.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/features/auth/presentation/cubits/logout_cubit/logout_cubit.dart';
import 'package:graduation_project/features/auth/presentation/views/sign_in/sign_in_view.dart';
import 'package:graduation_project/features/donor_features/find_ngo/presentation/views/find_ngo_view.dart';
import 'package:graduation_project/features/donor_features/my_donations/presentation/views/my_donations_view.dart';

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
    final user = getUser();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.name),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                user.name[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Color(0xFFE3F0FF),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Find NGO'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, FindNgoView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('My Donations'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, MyDonationsView.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              _showLogoutConfirmationDialog(context);
            },
          ),
        ],
      ),
    );
  }
}
