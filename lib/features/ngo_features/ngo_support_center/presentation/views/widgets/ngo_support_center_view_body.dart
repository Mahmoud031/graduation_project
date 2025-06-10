import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/features/donor_features/support_center/presentation/views/widgets/faq_section.dart';

import 'ngo_contact_support_card.dart';

class NgoSupportCenterViewBody extends StatefulWidget {
  const NgoSupportCenterViewBody({super.key});

  @override
  State<NgoSupportCenterViewBody> createState() =>
      _SupportCenterViewBodyState();
}

class _SupportCenterViewBodyState extends State<NgoSupportCenterViewBody> {
  final TextEditingController _searchController = TextEditingController();
  final List<FAQItem> _faqItems = [
    FAQItem(
      question: 'How do I manage incoming medicine donations?',
      answer:
          'You can manage all incoming donations through the "Donations" section. Here you can view, approve, reject, or mark donations as delivered. Each donation includes details like medicine name, quantity, expiry date, and donor information.',
    ),
    FAQItem(
      question: 'How do I track my medicine inventory?',
      answer:
          'Use the "Medicine Inventory" feature to track all medicines in your possession. You can view stock levels, expiry dates, and manage your inventory in real-time. The system automatically updates when new donations are received or medicines are distributed.',
    ),
    FAQItem(
      question: 'How can I generate reports about donations and inventory?',
      answer:
          'The "Reports" section provides comprehensive analytics including donation trends, inventory status, and donor performance. You can generate reports by category, time period, or specific metrics to help with planning and management.',
    ),
    FAQItem(
      question: 'What happens when I receive a medicine donation?',
      answer:
          'When a donation is received, you\'ll be notified through the app. You can then review the donation details, verify the medicine\'s condition and expiry date, and either approve or reject it. Approved donations will be added to your inventory automatically.',
    ),
    FAQItem(
      question: 'How do I manage medicine distribution?',
      answer:
          'Use the "Donation Management" feature to track and manage medicine distribution. You can record when medicines are distributed, to whom, and maintain a complete history of all distributions for reporting purposes.',
    ),
    FAQItem(
      question: 'How can I ensure medicine quality and safety?',
      answer:
          'The system helps you maintain quality by tracking expiry dates and requiring proper documentation for all donations. Always verify medicine packaging, expiry dates, and storage conditions before accepting donations.',
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
            NgoContactSupportCard(),
            const SizedBox(height: 30),
            FAQSection(faqItems: _faqItems),
          ],
        ),
      ),
    );
  }
}
