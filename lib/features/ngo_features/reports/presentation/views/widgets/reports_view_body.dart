import 'package:flutter/material.dart';
import '../../../../../../core/widgets/summary_card.dart';
import 'report_option_card.dart';

class ReportsViewBody extends StatelessWidget {
  const ReportsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reports',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SummaryCard(
                color: Color(0xFF23B3A7),
                count: '85',
                label: 'Total\nDonations',
              ),
              SummaryCard(
                color: Color(0xFF6B6BD6),
                count: '52',
                label: 'Donations\nIn Progress',
              ),
              SummaryCard(
                color: Color(0xFFF26A5B),
                count: '24',
                label: 'Completed\nDonations',
              ),
              SummaryCard(
                color: Color(0xFFF7B84B),
                count: '8',
                label: 'Cancelled\nDonations',
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView(
              children: const [
                ReportOptionCard(
                  icon: Icons.show_chart,
                  iconColor: Color(0xFF23B3A7),
                  title: 'Donations Over Time',
                  subtitle: 'Tracks donation trends over time',
                ),
                ReportOptionCard(
                  icon: Icons.bubble_chart,
                  iconColor: Color(0xFFF26A5B),
                  title: 'In-Progress Donations',
                  subtitle: 'Shows donations currently in progress',
                ),
                ReportOptionCard(
                  icon: Icons.pie_chart,
                  iconColor: Color(0xFF6B6BD6),
                  title: 'Completed Donations',
                  subtitle: 'Displays donations that have been completed',
                ),
                ReportOptionCard(
                  icon: Icons.category,
                  iconColor: Color(0xFFF7B84B),
                  title: 'Donations by Category',
                  subtitle: 'Breaks down donations by category',
                ),
                ReportOptionCard(
                  icon: Icons.location_on,
                  iconColor: Color(0xFF23B3A7),
                  title: 'Donations by Location',
                  subtitle: 'Analyzes donations based on location',
                ),
                ReportOptionCard(
                  icon: Icons.person,
                  iconColor: Color(0xFF6B6BD6),
                  title: 'Donors Report',
                  subtitle: 'Provides statistics on number of donors',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
