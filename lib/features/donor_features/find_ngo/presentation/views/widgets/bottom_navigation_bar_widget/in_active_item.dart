import 'package:flutter/material.dart';

class InActiveItem extends StatelessWidget {
  const InActiveItem({
    super.key,
    required this.icon,
  });
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return icon;
  }
}
