import 'package:flutter/material.dart';

class OnBoardingButton extends StatelessWidget {
  const OnBoardingButton({
    super.key,
    required this.text,
    required this.icon,
  });
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 133,
      height: 49,
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(1.00, 0.50),
          end: Alignment(0.00, 0.50),
          colors: [const Color(0xFF0C6171), const Color(0x42A0C2C6)],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontFamily: 'Judson',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 20),
            Container(
              width: 29,
              height: 27,
              decoration: ShapeDecoration(
                color: const Color(0xFFA4C6CC),
                shape: OvalBorder(),
              ),
              child: Icon(
                icon,
                color: Color(0xff2196F3),
              ),
            )
          ],
        ),
      ),
    );
  }
}
