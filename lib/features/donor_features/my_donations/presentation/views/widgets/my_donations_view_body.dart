import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/cubits/medicine_cubit/medicine_cubit.dart';
import 'package:graduation_project/core/widgets/custom_app_bar.dart';
import 'package:graduation_project/features/donor_features/my_donations/presentation/views/widgets/my_donation_card_view_bloc_builder.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import 'package:graduation_project/features/donor_features/add_medicine/domain/entities/medicine_entity.dart';

class MyDonationsViewBody extends StatefulWidget {
  const MyDonationsViewBody({super.key});

  @override
  State<MyDonationsViewBody> createState() => _MyDonationsViewBodyState();
}

class _MyDonationsViewBodyState extends State<MyDonationsViewBody> {
  String selectedStatus = 'All';
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<String> statusOptions = [
    'All',
    'Pending',
    'Approved',
    'Rejected',
    'Delivered',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<MedicineEntity> _filterMedicines(List<MedicineEntity> medicines) {
    return medicines.where((medicine) {
      // Status filter
      if (selectedStatus != 'All') {
        // Convert both strings to lowercase for case-insensitive comparison
        final medicineStatus = medicine.status.toLowerCase();
        final selectedStatusLower = selectedStatus.toLowerCase();

        if (medicineStatus != selectedStatusLower) {
          return false;
        }
      }

      // Search filter
      if (searchQuery.isNotEmpty) {
        final medicineName = medicine.medicineName.toLowerCase();
        final ngoName = medicine.ngoName.toLowerCase();
        final query = searchQuery.toLowerCase();

        if (!medicineName.contains(query) && !ngoName.contains(query)) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  @override
  void initState() {
    final user = getUser();
    context.read<MedicineCubit>().listenToDonorMedicines(user.uId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const CustomAppBar(
            title: 'My Donations',
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search medicine or NGO',
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey[600],
                          size: 20,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
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
                                fontSize: 14,
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
              ],
            ),
          ),
          const SizedBox(height: 20),
          BlocBuilder<MedicineCubit, MedicineState>(
            builder: (context, state) {
              if (state is MedicineSuccess) {
                final filteredMedicines = _filterMedicines(state.medicines);
                return MyDonationCardViewBlocBuilder(
                  medicines: filteredMedicines,
                );
              }
              return MyDonationCardViewBlocBuilder(
                medicines: const [],
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
