import 'package:flutter/material.dart';
import 'package:graduation_project/core/widgets/container_card.dart';

import 'ngo_options.dart';

class NgoHomeViewBody extends StatelessWidget {
  const NgoHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: NgoOptions.options.map((option) {
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