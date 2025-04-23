import 'package:flutter/material.dart';
import 'package:graduation_project/features/home/domain/entities/bottom_navigation_bar_entity.dart';
import 'navigation_bar_item.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 25,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: bottomNavigationBarItems.asMap().entries.map((e) {
            var index = e.key;
            var entity = e.value;
            return Expanded(
              flex: index == selectedIndex ? 5 : 4,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: NavigationBarItem(
                  isSelected: selectedIndex == index,
                  bottomNavigationBarEntity: entity,
                ),
              ),
            );
          }).toList(),
        ));
  }
}
