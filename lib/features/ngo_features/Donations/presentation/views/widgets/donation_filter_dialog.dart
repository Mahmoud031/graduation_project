import 'package:flutter/material.dart';
import '../../constants/donation_filter_constants.dart';

class DonationFilterDialog extends StatefulWidget {
  final String? selectedStatus;
  final String? selectedDateFilter;
  final String? selectedQuantityFilter;
  final Function(String?) onStatusChanged;
  final Function(String?) onDateFilterChanged;
  final Function(String?) onQuantityFilterChanged;
  final VoidCallback onReset;
  final VoidCallback onApply;

  const DonationFilterDialog({
    super.key,
    this.selectedStatus,
    this.selectedDateFilter,
    this.selectedQuantityFilter,
    required this.onStatusChanged,
    required this.onDateFilterChanged,
    required this.onQuantityFilterChanged,
    required this.onReset,
    required this.onApply,
  });

  @override
  State<DonationFilterDialog> createState() => _DonationFilterDialogState();
}

class _DonationFilterDialogState extends State<DonationFilterDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Donations'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Status',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: widget.selectedStatus,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: [
                const DropdownMenuItem(value: null, child: Text('All Status')),
                ...DonationFilterConstants.statusFilters.entries.map(
                  (entry) => DropdownMenuItem(
                    value: entry.key,
                    child: Text(entry.value),
                  ),
                ),
              ],
              onChanged: widget.onStatusChanged,
            ),
            const SizedBox(height: 16),
            const Text(
              'Date',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: widget.selectedDateFilter,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: [
                const DropdownMenuItem(value: null, child: Text('All Time')),
                ...DonationFilterConstants.dateFilters.entries.map(
                  (entry) => DropdownMenuItem(
                    value: entry.key,
                    child: Text(entry.value),
                  ),
                ),
              ],
              onChanged: widget.onDateFilterChanged,
            ),
            const SizedBox(height: 16),
            const Text(
              'Quantity',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: widget.selectedQuantityFilter,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: [
                const DropdownMenuItem(value: null, child: Text('All')),
                ...DonationFilterConstants.quantityFilters.entries.map(
                  (entry) => DropdownMenuItem(
                    value: entry.key,
                    child: Text(entry.value),
                  ),
                ),
              ],
              onChanged: widget.onQuantityFilterChanged,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onReset();
            Navigator.pop(context);
          },
          child: const Text('Reset'),
        ),
        TextButton(
          onPressed: () {
            widget.onApply();
            Navigator.pop(context);
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }
} 