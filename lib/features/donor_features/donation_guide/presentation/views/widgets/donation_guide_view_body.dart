import 'package:flutter/material.dart';
import 'package:graduation_project/features/donor_features/donation_guide/presentation/views/widgets/info_card.dart';
import 'package:graduation_project/features/donor_features/donation_guide/presentation/views/widgets/privacy_notice.dart';
import 'package:graduation_project/features/donor_features/donation_guide/presentation/views/widgets/section_title.dart';
import 'package:graduation_project/features/donor_features/donation_guide/presentation/views/widgets/step_card.dart';

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
            const SizedBox(height: 24),
            const SectionTitle(title: 'How to Donate: Step-by-Step'),
            const SizedBox(height: 16),
            const StepCard(
              step: 1,
              title: 'Sign Up or Log In',
              description: 'Create your donor account or log in to access all features.',
              icon: Icons.person,
            ),
            const StepCard(
              step: 2,
              title: 'Explore Home',
              description: 'From the Home screen, access all donor features: Add Medicine, Find NGO, View Requests, My Donations, and Support Center.',
              icon: Icons.home,
            ),
            const StepCard(
              step: 3,
              title: 'Find an NGO or View Requests',
              description: 'Search for NGOs by location, or browse active medicine requests from NGOs in need.',
              icon: Icons.search,
            ),
            const StepCard(
              step: 4,
              title: 'Donate Medicine',
              description: 'Select an NGO or a specific request, then fill in medicine details (name, count, expiry, image) and submit your donation.',
              icon: Icons.medical_services,
            ),
            const StepCard(
              step: 5,
              title: 'Track Your Donations',
              description: 'Monitor the status of your donations (Pending, Approved, Delivered, etc.) in the My Donations section.',
              icon: Icons.track_changes,
            ),
            const StepCard(
              step: 6,
              title: 'Get Support',
              description: 'Need help? Visit the Support Center for FAQs or contact support directly.',
              icon: Icons.support_agent,
            ),
            const SizedBox(height: 32),
            const SectionTitle(title: 'What Can You Donate?'),
            const SizedBox(height: 16),
            const InfoCard(
              title: 'Accepted Items',
              items: [
                'Unopened, sealed medicine packages',
                'Medicines with a valid (future) expiry date',
                'Properly stored medications (not exposed to heat/moisture)',
                'Clear image of the medicine, production and expiry dates',
                'Accurate information in all donation form fields',
              ],
              color: Color(0xFF4CAF50),
            ),
            const SizedBox(height: 16),
            const InfoCard(
              title: "Not Accepted",
              items: [
                'Expired medications',
                'Opened or damaged packages',
                'Prescription drugs without documentation',
                'Items not matching the provided details',
              ],
              color: Color(0xFFE57373),
            ),
            const SizedBox(height: 32),
            const SectionTitle(title: 'Your Rights & Responsibilities'),
            const SizedBox(height: 16),
            const InfoCard(
              title: 'Your Rights',
              items: [
                'Privacy of your personal and medical information',
                'Transparency in the donation process',
                'Right to withdraw consent at any time',
                'Access to your donation history',
              ],
              color: Color(0xFF2196F3),
            ),
            const SizedBox(height: 16),
            const InfoCard(
              title: 'Your Responsibilities',
              items: [
                'Provide accurate and honest information',
                'Ensure the quality and safety of donated medicine',
                'Follow all donation guidelines',
                'Respect confidentiality and privacy policies',
              ],
              color: Color(0xFF9C27B0),
            ),
            const SizedBox(height: 32),
            const SectionTitle(title: 'Support & Frequently Asked Questions'),
            const SizedBox(height: 16),
            InfoCard(
              title: 'Need Help?',
              items: [
                'Visit the Support Center from the Home screen',
                'Browse Frequently Asked Questions (FAQs)',
                'Contact support directly for personalized help',
              ],
              color: Colors.orange.shade300,
            ),
            const SizedBox(height: 16),
            const PrivacyNotice(),
          ],
        ),
      ),
    );
  }
}
