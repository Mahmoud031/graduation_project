import 'package:flutter/material.dart';
import 'package:graduation_project/core/widgets/container_card.dart';
import 'package:graduation_project/features/donor_features/home/presentation/views/widgets/donor_options.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double maxCrossAxisExtent = width > 600 ? 300 : 200;
    double childAspectRatio = width > 600 ? 1.2 : 0.9;
    return GridView.builder(
      padding: EdgeInsets.all(width * 0.05),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: maxCrossAxisExtent,
        crossAxisSpacing: width * 0.04,
        mainAxisSpacing: width * 0.04,
        childAspectRatio: childAspectRatio,
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
