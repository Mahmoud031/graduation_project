import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/cubit/medicine_invnetory_cubit/medicine_inventory_cubit.dart';
import 'package:intl/intl.dart';
import 'medicine_inventory_card_bloc_builder.dart';
import 'medicine_inventory_header.dart';

class MedicineInventoryViewBody extends StatefulWidget {
  const MedicineInventoryViewBody({super.key});

  @override
  State<MedicineInventoryViewBody> createState() =>
      _MedicineInventoryViewBodyState();
}

class _MedicineInventoryViewBodyState extends State<MedicineInventoryViewBody> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedCategory;
  String? _selectedExpiryFilter;
  String? _selectedQuantityFilter;

  DateTime _parseDate(String dateStr) {
    try {
      // Try parsing as dd/MM/yyyy
      final inputFormat = DateFormat('dd/MM/yyyy');
      return inputFormat.parse(dateStr);
    } catch (e) {
      try {
        // Try parsing as yyyy-MM-dd
        return DateTime.parse(dateStr);
      } catch (e) {
        // If both fail, return current date
        return DateTime.now();
      }
    }
  }

  @override
  void initState() {
    context.read<MedicineInventoryCubit>().getMedicineInventory();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
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
                  value: _selectedCategory,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  items: [
                    const DropdownMenuItem(
                        value: null, child: Text('All Categories')),
                    const DropdownMenuItem(
                        value: 'Painkiller', child: Text('Painkiller')),
                    const DropdownMenuItem(
                        value: 'Antibiotic', child: Text('Antibiotic')),
                    const DropdownMenuItem(
                        value: 'Cardiac', child: Text('Cardiac')),
                    const DropdownMenuItem(
                        value: 'Antiviral', child: Text('Antiviral')),
                    const DropdownMenuItem(
                        value: 'Antifungal', child: Text('Antifungal')),
                    const DropdownMenuItem(
                        value: 'Other', child: Text('Other')),
                  ],
                  onChanged: (value) {
                    setState(() => _selectedCategory = value);
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Expiry Status',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedExpiryFilter,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  items: [
                    const DropdownMenuItem(value: null, child: Text('All')),
                    const DropdownMenuItem(
                        value: 'expired', child: Text('Expired')),
                    const DropdownMenuItem(
                        value: 'expiring_soon', child: Text('Expiring Soon')),
                    const DropdownMenuItem(
                        value: 'valid', child: Text('Valid')),
                  ],
                  onChanged: (value) {
                    setState(() => _selectedExpiryFilter = value);
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Quantity',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedQuantityFilter,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  items: [
                    const DropdownMenuItem(value: null, child: Text('All')),
                    const DropdownMenuItem(
                        value: 'low_stock', child: Text('Low Stock')),
                    const DropdownMenuItem(
                        value: 'in_stock', child: Text('In Stock')),
                  ],
                  onChanged: (value) {
                    setState(() => _selectedQuantityFilter = value);
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedCategory = null;
                  _selectedExpiryFilter = null;
                  _selectedQuantityFilter = null;
                });
                Navigator.pop(context);
              },
              child: const Text('Reset'),
            ),
            TextButton(
              onPressed: () {
                this.setState(() {});
                Navigator.pop(context);
              },
              child: const Text('Apply'),
            ),
          ],
        ),
      ),
    );
  }

  List<dynamic> _filterMedicines(List<dynamic> medicines) {
    return medicines.where((medicine) {
      // Search query filter
      if (_searchQuery.isNotEmpty) {
        final medicineName = medicine.medicineName.toLowerCase();
        final category = medicine.category.toLowerCase();
        final query = _searchQuery.toLowerCase();

        if (!medicineName.contains(query) && !category.contains(query)) {
          return false;
        }
      }

      // Category filter
      if (_selectedCategory != null && medicine.category != _selectedCategory) {
        return false;
      }

      // Expiry filter
      if (_selectedExpiryFilter != null) {
        final expiryDate = _parseDate(medicine.expiryDate);
        final now = DateTime.now();
        final thirtyDaysFromNow = now.add(const Duration(days: 30));

        switch (_selectedExpiryFilter) {
          case 'expired':
            if (expiryDate.isAfter(now)) return false;
            break;
          case 'expiring_soon':
            if (expiryDate.isBefore(now) ||
                expiryDate.isAfter(thirtyDaysFromNow)) return false;
            break;
          case 'valid':
            if (expiryDate.isBefore(now)) return false;
            break;
        }
      }

      // Quantity filter
      if (_selectedQuantityFilter != null) {
        final quantity =
            int.tryParse(medicine.quantityAvailable.toString()) ?? 0;
        switch (_selectedQuantityFilter) {
          case 'low_stock':
            if (quantity > 10) return false;
            break;
          case 'in_stock':
            if (quantity <= 10) return false;
            break;
        }
      }

      return true;
    }).toList();
  }

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
          MedicineInventoryHeader(),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
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
                onPressed: _showFilterDialog,
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
            child: BlocBuilder<MedicineInventoryCubit, MedicineInventoryState>(
              builder: (context, state) {
                if (state is MedicineInventoryLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MedicineInventoryFailure) {
                  return Center(child: Text(state.message));
                } else if (state is MedicineInventorySuccess) {
                  final filteredMedicines = _filterMedicines(state.medicines);

                  if (filteredMedicines.isEmpty) {
                    return const Center(
                      child: Text(
                        'No medicines found',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }

                  return MedicineInventoryCardBlocBuilder(
                    medicines: filteredMedicines,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
