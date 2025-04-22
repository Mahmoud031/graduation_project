import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/features/home/presentation/views/add_medicine_view.dart';

import 'custom_home_button.dart';

class NgoInfo extends StatelessWidget {
  const NgoInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Container(
            padding: const EdgeInsets.only(
              top: 20.0,
              left: 20.0,
              right: 20.0,
              bottom: 10.0,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFE6F4F5),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoItem('NGO Name :', 'Ngo Two'),
                _buildInfoItem('Contact No :', '01120101517'),
                _buildInfoItem('Email :', 'mahmoudrady007@gmail.com'),
                _buildInfoItem('Address :', 'Aswan'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomHomeButton(
                      text: 'Add new medicine',
                      onPressed: () {
                        Navigator.pushNamed(context, AddMedicineView.routeName);
                      }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: RichText(
        text: TextSpan(
          style: TextStyles.textstyle18.copyWith(
            color: Colors.black54,
          ),
          children: [
            TextSpan(text: '$label '),
            TextSpan(
              text: value,
              style: TextStyles.textstyle18.copyWith(
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
