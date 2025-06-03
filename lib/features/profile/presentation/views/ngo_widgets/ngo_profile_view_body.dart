import 'package:flutter/material.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import 'package:graduation_project/features/auth/domain/entities/ngo_entity.dart';
import 'profile_header.dart';
import 'contact_info_section.dart';
import 'quick_actions_section.dart';
import 'statistics_grid.dart';
import '../widgets/edit_profile_button.dart';


class NgoProfileViewBody extends StatelessWidget {
  const NgoProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final NgoEntity ngo = getNgo();
    final theme = Theme.of(context);
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
              ProfileHeader(ngo: ngo),
              const SizedBox(height: 24),
              ContactInfoSection(ngo: ngo, theme: theme),
              const SizedBox(height: 20),
              QuickActionsSection(),
              const SizedBox(height: 20),
              StatisticsGrid(),
              const SizedBox(height: 28),
              const EditProfileButton(),
              const SizedBox(height: 16),
            ],
          ),
        ),
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
