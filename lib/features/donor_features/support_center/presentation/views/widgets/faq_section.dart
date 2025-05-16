import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/features/donor_features/support_center/presentation/utils/support_center_colors.dart';

class FAQSection extends StatelessWidget {
  final List<FAQItem> faqItems;

  const FAQSection({
    super.key,
    required this.faqItems,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.help_outline,
              color: SupportCenterColors.primary,
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              'Frequently Asked Questions',
              style: TextStyles.textstyle25.copyWith(
                fontWeight: FontWeight.bold,
                color: SupportCenterColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ...faqItems.map((item) => FAQItemWidget(item: item)).toList(),
      ],
    );
  }
}

class FAQItemWidget extends StatefulWidget {
  final FAQItem item;

  const FAQItemWidget({
    super.key,
    required this.item,
  });

  @override
  State<FAQItemWidget> createState() => _FAQItemWidgetState();
}

class _FAQItemWidgetState extends State<FAQItemWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _heightFactor;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _heightFactor = _animationController.drive(CurveTween(curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: SupportCenterColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: SupportCenterColors.primary.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: (expanded) => _toggleExpanded(),
          title: Row(
            children: [
              Icon(
                _isExpanded ? Icons.remove_circle_outline : Icons.add_circle_outline,
                color: SupportCenterColors.accent,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.item.question,
                  style: TextStyles.textstyle18.copyWith(
                    fontWeight: FontWeight.w600,
                    color: SupportCenterColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return ClipRect(
                  child: Align(
                    heightFactor: _heightFactor.value,
                    child: child,
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(48, 0, 16, 16),
                child: Text(
                  widget.item.answer,
                  style: TextStyles.textstyle16.copyWith(
                    color: SupportCenterColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({
    required this.question,
    required this.answer,
  });
} 