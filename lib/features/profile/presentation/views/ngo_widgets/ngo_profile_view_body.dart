import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import 'package:graduation_project/features/auth/domain/entities/ngo_entity.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';
import 'package:graduation_project/features/auth/presentation/cubits/logout_cubit/logout_cubit.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/features/auth/presentation/views/sign_in_view.dart';
import '../edit_ngo_profile_view.dart';
import 'ngo_profile_header.dart';
import 'contact_info_section.dart';
import 'ngo_quick_actions_section.dart';
import 'ngo_statistics_grid.dart';
import '../widgets/edit_profile_button.dart';
import '../widgets/logout_button.dart';

class NgoProfileViewBody extends StatelessWidget {
  const NgoProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final NgoEntity ngo = getNgo();
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => LogoutCubit(getIt.get<AuthRepo>()),
      child: BlocConsumer<LogoutCubit, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              SigninView.routeName,
              (route) => false,
            );
          } else if (state is LogoutFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE3F0FF), Color(0xFFF8F6FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    NgoProfileHeader(ngo: ngo),
                    const SizedBox(height: 24),
                    ContactInfoSection(ngo: ngo, theme: theme),
                    const SizedBox(height: 20),
                    NgoQuickActionsSection(),
                    const SizedBox(height: 20),
                    NgoStatisticsGrid(),
                    const SizedBox(height: 28),
                    EditProfileButton(
                      onPressed: () {
                        Navigator.pushNamed(context, EditNgoProfileView.routeName);
                      },
                    ),
                    const SizedBox(height: 16),
                    const LogoutButton(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  int extractLeadingNumber(String value) {
    final match = RegExp(r'^(\d+)').firstMatch(value.trim());
    if (match != null) {
      return int.tryParse(match.group(1)!) ?? 0;
    }
    return 0;
  }
}

// Extension for color darken
extension ColorUtils on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}
