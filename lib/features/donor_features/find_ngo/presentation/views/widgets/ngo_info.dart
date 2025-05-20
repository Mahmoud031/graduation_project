import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/features/auth/data/models/ngo_model.dart';
import 'package:graduation_project/features/donor_features/add_medicine/presentation/views/add_medicine_view.dart';
import 'package:graduation_project/features/donor_features/find_ngo/presentation/views/widgets/custom_home_button.dart';

class NgoInfo extends StatelessWidget {
  final NgoModel ngo;

  const NgoInfo({
    super.key,
    required this.ngo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFC2E1E3),
          border: Border.all(
            color: const Color(0xFF888888).withOpacity(0.2),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF888888).withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NGO Information',
              style: TextStyles.textstyle25.copyWith(
                fontSize: MediaQuery.of(context).size.width * 0.06,
                color: const Color(0xFF888888),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Name: ${ngo.name}',
              style: TextStyles.textstyle18.copyWith(
                color: const Color(0xFF888888),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Location: ${ngo.address}',
              style: TextStyles.textstyle18.copyWith(
                color: const Color(0xFF888888),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Contact: ${ngo.phone}',
              style: TextStyles.textstyle18.copyWith(
                color: const Color(0xFF888888),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: CustomHomeButton(
                text: 'Add New Medicine',
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AddMedicineView.routeName,
                    arguments: ngo.name ?? '',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
