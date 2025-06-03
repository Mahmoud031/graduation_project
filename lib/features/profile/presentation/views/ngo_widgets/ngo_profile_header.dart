import 'package:flutter/material.dart';
import 'package:graduation_project/features/auth/domain/entities/ngo_entity.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';

class NgoProfileHeader extends StatelessWidget {
  final NgoEntity ngo;
  const NgoProfileHeader({super.key, required this.ngo});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
                border: Border.all(color: Colors.white, width: 4),
              ),
              child: CircleAvatar(
                radius: 48,
                backgroundColor: Colors.blue.shade400,
                child: Text(
                  ngo.name[0].toUpperCase(),
                  style: TextStyles.textstyle25.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              ngo.name,
              style: TextStyles.textstyle25.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'NGO ID: ${ngo.ngoId}',
              style: TextStyles.textstyle14.copyWith(
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
