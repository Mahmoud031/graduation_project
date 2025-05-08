import 'package:flutter/material.dart';
import 'package:graduation_project/core/widgets/custom_app_bar.dart';

import 'transaction_card.dart';

class ViewTransactionViewBody extends StatelessWidget {
  const ViewTransactionViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const CustomAppBar(
            title: 'My Transactions',
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        const Text(
                          'Status: All',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey.shade600,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        const Text(
                          'April 2025',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey.shade600,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          TransactionCard(
            organizationName: 'Hope Foundation',
            date: 'April 15, 2025',
            medicines: ['Paracetamol', 'Aspirin'],
            status: 'Completed',
            statusColor: Colors.green.shade100,
            textColor: Colors.green.shade700,
          ),
          const SizedBox(height: 16),
          TransactionCard(
            organizationName: 'Aid for All',
            date: 'April 1, 2025',
            medicines: ['Ibuprofen'],
            status: 'Pending',
            statusColor: Colors.orange.shade100,
            textColor: Colors.orange.shade700,
          ),
        ],
      ),
    );
  }
}
