import 'package:flutter/material.dart';
import '../../../../../../core/widgets/summary_card.dart';
import 'medicine_card.dart';

class MedicineInventoryViewBody extends StatelessWidget {
  const MedicineInventoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Medicine Inventory',
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
                count: '120',
                label: 'Types\nMedicine ',
              ),
              SummaryCard(
                color: Color(0xFF3DC88F),
                count: '650',
                label: 'Units\nIn Stock',
              ),
              SummaryCard(
                color: Color(0xFFF7B84B),
                count: '20',
                label: 'Units\nLow Stock',
              ),
              SummaryCard(
                color: Color(0xFFF26A5B),
                count: '15',
                label: 'Uniting\nExpiring Soon',
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
                MedicineCard(
                  name: 'Paracetamol 500mg',
                  type: 'Pain Relief',
                  stock: 120,
                  expiry: '2025-09-15',
                  donor: '#302',
                  received: '2024-05-12',
                  condition: 'Unopened, original pack',
                ),
                MedicineCard(
                  name: 'Amoxicillin 250mg',
                  type: 'Antibiotic',
                  stock: 80,
                  expiry: '2025-12-15',
                  donor: '#145',
                  received: '2024-07-20',
                  condition: 'Opened, good condition',
                ),
                MedicineCard(
                  name: 'Loratadine 10mg',
                  type: 'Antihistamine',
                  stock: 60,
                  expiry: '2024-06-30',
                  donor: '#230',
                  received: '2024-12-10',
                  condition: 'Unopened, original pack',
                  isExpiryWarning: true,
                ),
                MedicineCard(
                  name: 'Metformin 500mg',
                  type: 'Diabetes',
                  stock: 140,
                  expiry: '2025-02-06',
                  donor: '#110',
                  received: '2024-03-01',
                  condition: 'Unopened, original pack',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
