import 'package:flutter/material.dart';
import 'package:graduation_project/features/donor_features/add_medicine/domain/entities/medicine_entity.dart';
import 'donation_card_items.dart';

class DonationCard extends StatelessWidget {
  final List<MedicineEntity> medicine;

  const DonationCard({
    super.key,
    required this.medicine,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7, // 70% of screen height
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: medicine.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: DonationsCardItems(
            medicineEntity: medicine[index],
          ),
        ),
      ),
    );
  }
}
