import 'package:flutter/material.dart';
import '../../../../../../core/widgets/summary_card.dart';
import 'donation_card.dart';

class DonationsViewBody extends StatelessWidget {
  const DonationsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Donations',
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
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  side: const BorderSide(color: Colors.black12),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
                child: const Text('Filter'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: const [
                DonationCard(
                  title: 'Food Aid for Families',
                  id: '1317',
                  status: 'Completed',
                  statusIcon: Icons.check_circle,
                  statusColor: Color(0xFF23B3A7),
                  donor: 'Donor #057',
                  date: '2024-10-20',
                  location: 'Central District',
                ),
                DonationCard(
                  title: 'Winter Relief Program',
                  id: '1317',
                  status: 'In Progress',
                  statusIcon: Icons.check_circle,
                  statusColor: Color(0xFF23B3A7),
                  donor: 'Donor #057',
                  date: '2024-01-15',
                ),
                DonationCard(
                  title: 'Medical Supplies Fund',
                  id: '1317',
                  status: 'In Progress',
                  statusIcon: Icons.check_circle,
                  statusColor: Color(0xFF23B3A7),
                  donor: 'Donor #055',
                  date: '2024-04-05',
                ),
                DonationCard(
                  title: 'Education Support',
                  id: '1316',
                  status: 'Cancelled',
                  statusIcon: Icons.cancel,
                  statusColor: Color(0xFFF7B84B),
                  donor: 'Donor #230',
                  date: '2023-12-12',
                ),
                DonationCard(
                  title: 'Cancation Support',
                  id: '1316',
                  status: 'Cancelled',
                  statusIcon: Icons.cancel,
                  statusColor: Color(0xFFF7B84B),
                  donor: '2023-12-12',
                  date: '2023-12-12',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
