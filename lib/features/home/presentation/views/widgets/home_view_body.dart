import 'package:flutter/material.dart';
import 'package:graduation_project/features/home/presentation/views/widgets/donation_card.dart';
import 'package:graduation_project/features/home/presentation/views/widgets/donation_options.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: DonationOptions.options.map((option) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: DonationCard(
                title: option.title,
                imagePath: option.imagePath,
                color: option.color,
                onTap: () {
                  Navigator.pushNamed(context, option.route);
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
