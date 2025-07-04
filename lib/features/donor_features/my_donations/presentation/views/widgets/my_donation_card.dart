import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/features/donor_features/add_medicine/domain/entities/medicine_entity.dart';
import 'my_donation_card_items.dart';

class MyDonationsCard extends StatelessWidget {
  final List<MedicineEntity> medicine;

  const MyDonationsCard({
    super.key,
    required this.medicine,
  });

  @override
  Widget build(BuildContext context) {
    if (medicine.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Center(
          child: Text(
            'No donations yet.',
            style: TextStyles.textstyle18.copyWith(
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7, // 70% of screen height
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: medicine.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: MyDonationsCardItems(
            medicineEntity: medicine[index],
          ),
        ),
      ),
    );
  }
}
