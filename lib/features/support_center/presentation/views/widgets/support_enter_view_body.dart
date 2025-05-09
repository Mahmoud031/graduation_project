import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/features/support_center/presentation/views/widgets/contact_support_card.dart';
import 'package:graduation_project/features/support_center/presentation/views/widgets/faq_section.dart';

class SupportCenterViewBody extends StatefulWidget {
  const SupportCenterViewBody({super.key});

  @override
  State<SupportCenterViewBody> createState() => _SupportCenterViewBodyState();
}

class _SupportCenterViewBodyState extends State<SupportCenterViewBody> {
  final TextEditingController _searchController = TextEditingController();
  final List<FAQItem> _faqItems = [
    FAQItem(
      question: 'How do I donate medicine?',
      answer:
          'To donate medicine, go to the "Donate Medicine" section, fill in the required details including medicine name, expiry date, and upload a clear image of the medicine. Make sure the production and expiration dates are visible in the image.',
    ),
    FAQItem(
      question: 'What types of medicines can I donate?',
      answer:
          'You can donate any unexpired, unopened, and properly stored medicines. Please ensure the medicine is in its original packaging and has not been tampered with.',
    ),
    FAQItem(
      question: 'How do I find nearby NGOs?',
      answer:
          'Use the "Find NGO" feature in the app. You can search by location to find NGOs in your area that accept medicine donations.',
    ),
    FAQItem(
      question: 'Is my donation tax-deductible?',
      answer:
          'Yes, all donations made through our platform are tax-deductible. You will receive a receipt for your donation that you can use for tax purposes.',
    ),
    FAQItem(
      question: 'How do I track my donations?',
      answer:
          'You can track all your donations in the "My Donations" section. This includes both medicine and monetary donations.',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              'Support Center',
              style: TextStyles.textstyle25.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF071A26),
              ),
            ),
            const SizedBox(height: 20),
            ContactSupportCard(),
            const SizedBox(height: 30),
            FAQSection(faqItems: _faqItems),
          ],
        ),
      ),
    );
  }
}
