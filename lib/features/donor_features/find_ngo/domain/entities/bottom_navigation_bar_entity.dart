import 'package:flutter/material.dart';

class BottomNavigationBarEntity {
  final Icon activeIcon, inActiveIcon;
  final String name;

  BottomNavigationBarEntity(
      {required this.activeIcon,
      required this.inActiveIcon,
      required this.name});
}

List<BottomNavigationBarEntity> get bottomNavigationBarItems => [
      BottomNavigationBarEntity(
        activeIcon: Icon(
          Icons.home,
          color: Color(0xFF174B4A),
        ),
        inActiveIcon: Icon(Icons.home_outlined, color: Colors.grey),
        name: 'Home',
      ),
      BottomNavigationBarEntity(
        activeIcon: Icon(
          Icons.receipt_long,
          color: Color(0xFF174B4A),
        ),
        inActiveIcon: Icon(Icons.receipt_long_outlined, color: Colors.grey),
        name: 'Transactions',
      ),
      BottomNavigationBarEntity(
        activeIcon: Icon(Icons.person, color: Color(0xFF174B4A)),
        inActiveIcon: Icon(Icons.person_outlined, color: Colors.grey),
        name: 'Profile',
      ),
    ];
