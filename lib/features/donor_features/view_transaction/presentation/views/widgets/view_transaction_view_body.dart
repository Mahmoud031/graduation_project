import 'package:flutter/material.dart';
import 'package:graduation_project/core/widgets/custom_app_bar.dart';

import 'transaction_card.dart';

class ViewTransactionViewBody extends StatefulWidget {
  const ViewTransactionViewBody({super.key});

  @override
  State<ViewTransactionViewBody> createState() => _ViewTransactionViewBodyState();
}

class _ViewTransactionViewBodyState extends State<ViewTransactionViewBody> {
  String selectedStatus = 'All';
  String selectedMonth = 'April 2025';

  final List<String> statusOptions = ['All', 'Pending', 'Completed', 'Rejected'];
  final List<String> monthOptions = [
    'January 2025',
    'February 2025',
    'March 2025',
    'April 2025',
    'May 2025',
    'June 2025',
    // Add more months as needed
  ];

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
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedStatus,
                        isExpanded: true,
                        items: statusOptions.map((status) {
                          return DropdownMenuItem(
                            value: status,
                            child: Text(
                              'Status: $status',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedStatus = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedMonth,
                        isExpanded: true,
                        items: monthOptions.map((month) {
                          return DropdownMenuItem(
                            value: month,
                            child: Text(
                              month,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedMonth = value!;
                          });
                        },
                      ),
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
