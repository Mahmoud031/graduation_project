import 'package:flutter/material.dart';
import 'package:graduation_project/features/donation_guide/presentation/views/widgets/info_card.dart';
import 'package:graduation_project/features/donation_guide/presentation/views/widgets/privacy_notice.dart';
import 'package:graduation_project/features/donation_guide/presentation/views/widgets/section_title.dart';
import 'package:graduation_project/features/donation_guide/presentation/views/widgets/step_card.dart';

class DonationGuideViewBody extends StatelessWidget {
  const DonationGuideViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Donation Guide',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32), // Deep green color
              ),
            ),
            const SizedBox(height: 24),
            const SectionTitle(title: 'Step-by-Step Guide'),
            const SizedBox(height: 16),
            const StepCard(
              step: 1,
              title: 'Sign Up',
              description: 'Create your account to start your donation journey',
              icon: Icons.person_add,
            ),
            const StepCard(
              step: 2,
              title: 'Verify Account',
              description: 'Complete verification to ensure secure donations',
              icon: Icons.verified_user,
            ),
            const StepCard(
              step: 3,
              title: 'Choose Donation Type',
              description: 'Select the type of medicine you wish to donate',
              icon: Icons.medical_services,
            ),
            const StepCard(
              step: 4,
              title: 'Track Status',
              description: 'Monitor your donation\'s journey and impact',
              icon: Icons.track_changes,
            ),
            const SizedBox(height: 32),
            const SectionTitle(title: 'Accepted Items'),
            const SizedBox(height: 16),
            const InfoCard(
              title: 'What We Accept',
              items: [
                'Unopened medicine packages',
                'Medicines within expiry date',
                'Properly stored medications',
                'Original packaging',
              ],
              color: Color(0xFF4CAF50), // Light green
            ),
            const SizedBox(height: 16),
            const InfoCard(
              title: 'What We Don\'t Accept',
              items: [
                'Expired medications',
                'Opened packages',
                'Damaged items',
                'Prescription drugs without proper documentation',
              ],
              color: Color(0xFFE57373), // Light red
            ),
            const SizedBox(height: 32),
            const SectionTitle(title: 'Donor Rights & Responsibilities'),
            const SizedBox(height: 16),
            const InfoCard(
              title: 'Your Rights',
              items: [
                'Privacy of your medical information',
                'Transparency in donation process',
                'Right to withdraw consent',
                'Access to donation history',
              ],
              color: Color(0xFF2196F3), // Blue
            ),
            const SizedBox(height: 16),
            const InfoCard(
              title: 'Your Responsibilities',
              items: [
                'Provide accurate information',
                'Ensure medicine quality',
                'Follow donation guidelines',
                'Maintain confidentiality',
              ],
              color: Color(0xFF9C27B0), // Purple
            ),
            const SizedBox(height: 24),
            const PrivacyNotice(),
          ],
        ),
      ),
    );
  }
}
