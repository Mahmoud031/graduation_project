import 'package:flutter/material.dart';
import 'package:graduation_project/core/widgets/summary_card.dart';

class DonationsHeader extends StatelessWidget {
  const DonationsHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        SummaryCard(
          color: Color(0xFF23B3A7),
          count: '125',
          label: 'Total\nDonations',
        ),
        SummaryCard(
          color: Color(0xFF6B6BD6),
          count: '83',
          label: 'In Progress',
        ),
        SummaryCard(
          color: Color(0xFFF26A5B),
          count: '30',
          label: 'Completed',
        ),
        SummaryCard(
          color: Color(0xFFF7B84B),
          count: '12',
          label: 'Cancelled',
        ),
      ],
    );
  }
}
