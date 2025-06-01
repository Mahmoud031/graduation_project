import 'package:flutter/material.dart';
import '../../constants/filter_constants.dart';

class MedicineFilterDialog extends StatefulWidget {
  final String? selectedCategory;
  final String? selectedExpiryFilter;
  final String? selectedQuantityFilter;
  final Function(String?) onCategoryChanged;
  final Function(String?) onExpiryFilterChanged;
  final Function(String?) onQuantityFilterChanged;
  final VoidCallback onReset;
  final VoidCallback onApply;

  const MedicineFilterDialog({
    super.key,
    this.selectedCategory,
    this.selectedExpiryFilter,
    this.selectedQuantityFilter,
    required this.onCategoryChanged,
    required this.onExpiryFilterChanged,
    required this.onQuantityFilterChanged,
    required this.onReset,
    required this.onApply,
  });

  @override
  State<MedicineFilterDialog> createState() => _MedicineFilterDialogState();
}

class _MedicineFilterDialogState extends State<MedicineFilterDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Medicines'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Category',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: widget.selectedCategory,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: [
                const DropdownMenuItem(value: null, child: Text('All Categories')),
                ...FilterConstants.categories.map(
                  (category) => DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  ),
                ),
              ],
              onChanged: widget.onCategoryChanged,
            ),
            const SizedBox(height: 16),
            const Text(
              'Expiry Status',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: widget.selectedExpiryFilter,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: [
                const DropdownMenuItem(value: null, child: Text('All')),
                ...FilterConstants.expiryFilters.entries.map(
                  (entry) => DropdownMenuItem(
                    value: entry.key,
                    child: Text(entry.value),
                  ),
                ),
              ],
              onChanged: widget.onExpiryFilterChanged,
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
                ...FilterConstants.quantityFilters.entries.map(
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