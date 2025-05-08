import 'package:flutter/material.dart';
import 'package:graduation_project/features/find_ngo/domain/entities/bottom_navigation_bar_entity.dart';
import 'package:graduation_project/features/find_ngo/presentation/views/widgets/bottom_navigation_bar_widget/acitve_item.dart';

import 'in_active_item.dart';

class NavigationBarItem extends StatelessWidget {
  const NavigationBarItem(
      {super.key,
      required this.isSelected,
      required this.bottomNavigationBarEntity});
  final bool isSelected;
  final BottomNavigationBarEntity bottomNavigationBarEntity;
  @override
  Widget build(BuildContext context) {
    return isSelected
        ? ActiveItem(
            icon: bottomNavigationBarEntity.activeIcon,
            text: bottomNavigationBarEntity.name,
        )
        : InActiveItem(
            icon: bottomNavigationBarEntity.inActiveIcon,
          );
  }
}
