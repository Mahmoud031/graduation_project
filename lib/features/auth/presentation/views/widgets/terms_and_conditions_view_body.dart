import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_images.dart';
import 'package:graduation_project/core/widgets/custom_button.dart';

class TermsAndConditionsViewBody extends StatelessWidget {
  const TermsAndConditionsViewBody({super.key});

  Widget _sectionCard({
    required IconData icon,
    required String title,
    required List<String> content,
    Color? iconColor,
    Color? cardColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardColor ?? Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor ?? Colors.blue, size: 28),
              const SizedBox(width: 10),
              Text(title,
                  style: TextStyles.textstyle18.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          ...content.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  '\u2022 $e',
                  style: TextStyles.textstyle16.copyWith(
                      color: Colors.black87, fontWeight: FontWeight.normal),
                ),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Image.asset(AppImages.logo, height: 80),
              const SizedBox(height: 10),
              Text(
                'Terms & Conditions',
                style: TextStyles.textstyle30.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Welcome to PharmaShare! By using our platform, you agree to the following terms and conditions. Please read them carefully.',
                style: TextStyles.textstyle16.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),
              _sectionCard(
                icon: Icons.verified_user,
                title: 'Your Responsibilities',
                iconColor: Colors.deepPurple,
                content: [
                  'Provide accurate and truthful information during registration and donation.',
                  'Donate only medicines and items that are accepted by the platform.',
                  'Ensure all donated medicines are within expiry and in good condition.',
                  'Follow all donation guidelines and instructions provided.',
                  'Maintain confidentiality and respect the privacy of others.',
                ],
              ),
              _sectionCard(
                icon: Icons.privacy_tip,
                title: 'Privacy & Data Protection',
                iconColor: Colors.green,
                content: [
                  'Your personal and medical information is handled with utmost confidentiality.',
                  'We comply with all data protection regulations.',
                  'Your information will never be shared without your explicit consent.',
                ],
              ),
              _sectionCard(
                icon: Icons.medical_services,
                title: 'Donation Guidelines',
                iconColor: Colors.blue,
                content: [
                  'We do NOT accept expired, opened, or damaged medicines.',
                  'Prescription drugs require proper documentation.',
                  'Follow all safety and quality guidelines when donating.',
                ],
              ),
              _sectionCard(
                icon: Icons.warning_amber_rounded,
                title: 'Disclaimers',
                iconColor: Colors.redAccent,
                content: [
                  'PharmaShare is not liable for misuse of the platform or donated items.',
                  'Users are responsible for verifying the information and quality of donations.',
                  'We reserve the right to refuse or remove any donation that does not meet our standards.',
                ],
              ),
              _sectionCard(
                icon: Icons.emoji_events,
                title: 'Your Rights',
                iconColor: Colors.orange,
                content: [
                  'Right to privacy and data protection.',
                  'Right to withdraw consent at any time.',
                  'Right to access your donation history and information.',
                  'Right to transparency in all donation processes.',
                ],
              ),
              _sectionCard(
                icon: Icons.support_agent,
                title: 'Support & Contact',
                iconColor: Colors.teal,
                content: [
                  'If you have any questions or need help, please contact our support center through the app.',
                  'We are here to assist you with any issues or concerns.',
                ],
              ),
              const SizedBox(height: 30),
              CustomButton(
                text: 'Back',
                size: Size(MediaQuery.of(context).size.width * 0.7, 50),
                onPressed: () => Navigator.of(context).pop(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
