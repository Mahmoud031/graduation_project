import 'package:flutter/material.dart';
import 'package:graduation_project/core/widgets/container_card.dart';

import 'ngo_options.dart';

class NgoHomeViewBody extends StatelessWidget {
  const NgoHomeViewBody({super.key});

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
      itemCount: NgoOptions.options.length,
      itemBuilder: (context, index) {
        final option = NgoOptions.options[index];
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