import 'package:flutter/material.dart';
import 'package:graduation_project/core/widgets/container_card.dart';
import 'package:graduation_project/features/donor_features/home/presentation/views/widgets/donor_options.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: DonorOptions.options.map((option) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ContainerCard(
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
