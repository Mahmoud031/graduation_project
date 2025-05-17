import 'package:flutter/material.dart';
import '../../../../../../core/widgets/summary_card.dart';
import 'shipment_card.dart';

class DonationManagementViewBody extends StatelessWidget {
  const DonationManagementViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Donation Management',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SummaryCard(
                color: Color(0xFF23B3A7),
                count: '20',
                label: 'Total\nShipments',
              ),
              SummaryCard(
                color: Color(0xFF6B6BD6),
                count: '12',
                label: 'Shipments\nin Transit',
              ),
              SummaryCard(
                color: Color(0xFFF7B84B),
                count: '18',
                label: 'Delivered\nShipments',
              ),
              SummaryCard(
                color: Color(0xFFF26A5B),
                count: '5',
                label: 'Cancelled\nShipments',
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Shipment History',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: const [
                ShipmentCard(
                  shipmentNumber: 'Shipment #2345',
                  location: 'New York, NY',
                  dateTime: 'April 21, 2024 14:30',
                  status: 'In Transit',
                  icon: Icons.local_shipping,
                  iconColor: Color(0xFF23B3A7),
                  statusColor: Color(0xFF23B3A7),
                ),
                ShipmentCard(
                  shipmentNumber: 'Shipment #2344',
                  location: 'Los Angeles, CA',
                  dateTime: 'April 20, 2024 09:45',
                  status: 'Delivered',
                  icon: Icons.check_circle,
                  iconColor: Color(0xFF3DC88F),
                  statusColor: Color(0xFF3DC88F),
                ),
                ShipmentCard(
                  shipmentNumber: 'Shipment #2343',
                  location: 'Chicago, IL',
                  dateTime: 'April 18, 2024 16:20',
                  status: 'Cancelled',
                  icon: Icons.cancel,
                  iconColor: Color(0xFFF26A5B),
                  statusColor: Color(0xFFF26A5B),
                ),
                ShipmentCard(
                  shipmentNumber: 'Shipment #2342',
                  location: 'Houston, TX',
                  dateTime: 'April 17, 2024 11:10',
                  status: 'Delivered',
                  icon: Icons.check_circle,
                  iconColor: Color(0xFF3DC88F),
                  statusColor: Color(0xFF3DC88F),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
