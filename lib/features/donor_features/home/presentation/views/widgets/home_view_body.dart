import 'package:flutter/material.dart';
import 'package:graduation_project/core/widgets/container_card.dart';
import 'package:graduation_project/features/donor_features/home/presentation/views/widgets/donor_options.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(20.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
        childAspectRatio: 0.9,
      ),
      itemCount: DonorOptions.options.length,
      itemBuilder: (context, index) {
        final option = DonorOptions.options[index];
        return ContainerCard(
          title: option.title,
          imagePath: option.imagePath,
          color: option.color,
          onTap: () {
            Navigator.pushNamed(context, option.route);
          },
        );
      },
    );
  }
}
