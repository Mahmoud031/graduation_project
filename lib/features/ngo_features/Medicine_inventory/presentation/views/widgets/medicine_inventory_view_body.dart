import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/cubit/medicine_invnetory_cubit/medicine_inventory_cubit.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import '../../utils/medicine_filter_utils.dart';
import 'medicine_inventory_card_bloc_builder.dart';
import 'medicine_inventory_header.dart';
import 'medicine_filter_dialog.dart';

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

  @override
  void initState() {
    super.initState();
    final ngo = getNgo();
    context.read<MedicineInventoryCubit>().listenToNgoInventory(ngo.uId);
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
        builder: (context, setState) => MedicineFilterDialog(
          selectedCategory: _selectedCategory,
          selectedExpiryFilter: _selectedExpiryFilter,
          selectedQuantityFilter: _selectedQuantityFilter,
          onCategoryChanged: (value) {
            setState(() => _selectedCategory = value);
          },
          onExpiryFilterChanged: (value) {
            setState(() => _selectedExpiryFilter = value);
          },
          onQuantityFilterChanged: (value) {
            setState(() => _selectedQuantityFilter = value);
          },
          onReset: () {
            setState(() {
              _selectedCategory = null;
              _selectedExpiryFilter = null;
              _selectedQuantityFilter = null;
            });
          },
          onApply: () {
            this.setState(() {});
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  final filteredMedicines = MedicineFilterUtils.filterMedicines(
                    medicines: state.medicines,
                    searchQuery: _searchQuery,
                    selectedCategory: _selectedCategory,
                    selectedExpiryFilter: _selectedExpiryFilter,
                    selectedQuantityFilter: _selectedQuantityFilter,
                  );

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
