import 'package:flutter/material.dart';
import 'package:graduation_project/features/auth/presentation/views/sign_up_ngo_view.dart';
import 'package:graduation_project/features/auth/presentation/views/sign_up_view.dart';

class MemebrToggle extends StatelessWidget {
  const MemebrToggle({
    super.key,
    required this.isMemberSelected,
    this.onToggle,
  });

  final bool isMemberSelected;
  final Function(bool)? onToggle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (onToggle != null) {
                  onToggle!(true);
                } else {
                  Navigator.pushReplacementNamed(context, SignUpView.routeName);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isMemberSelected
                      ? const Color(0xFF2C414B)
                      : const Color(0xffD9D9D9),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Member',
                    style: TextStyle(
                      color: isMemberSelected ? Colors.white : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (onToggle != null) {
                  onToggle!(false);
                } else {
                  Navigator.pushReplacementNamed(
                      context, SignUpNgoView.routeName);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isMemberSelected
                      ? const Color(0xffD9D9D9)
                      : const Color(0xFF2C414B),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Center(
                  child: Text(
                    'NGO',
                    style: TextStyle(
                      color: isMemberSelected ? Colors.black : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
