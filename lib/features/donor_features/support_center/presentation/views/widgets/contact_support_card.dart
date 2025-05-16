import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/features/donor_features/support_center/presentation/utils/support_center_colors.dart';

import '../contact_support_view.dart';

class ContactSupportCard extends StatefulWidget {
  

  const ContactSupportCard({
    super.key,
    
  });

  @override
  State<ContactSupportCard> createState() => _ContactSupportCardState();
}

class _ContactSupportCardState extends State<ContactSupportCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
      if (isHovered) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: SupportCenterColors.primaryGradient,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? SupportCenterColors.primary.withOpacity(0.3)
                    : SupportCenterColors.primary.withOpacity(0.1),
                spreadRadius: _isHovered ? 2 : 1,
                blurRadius: _isHovered ? 8 : 4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.support_agent,
                    color: Colors.white.withOpacity(0.9),
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Need Help?',
                    style: TextStyles.textstyle25.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Our support team is here to help you',
                style: TextStyles.textstyle18.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 20),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ContactSupportView.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _isHovered ? SupportCenterColors.accent : Colors.white,
                    foregroundColor:
                        _isHovered ? Colors.white : SupportCenterColors.primary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: _isHovered ? 4 : 2,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.message_outlined,
                        size: 20,
                        color: _isHovered
                            ? Colors.white
                            : SupportCenterColors.primary,
                      ),
                      const SizedBox(width: 8),
                      const Text('Contact Support'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
