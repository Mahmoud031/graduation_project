import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/cubits/medicine_cubit/medicine_cubit.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import 'package:graduation_project/core/services/database_service.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/core/utils/backend_endpoint.dart';
import 'package:graduation_project/features/ngo_features/Donation_Management/presentation/views/widgets/received_donations/donation_status.dart';
import 'package:intl/intl.dart';
import 'ngo_donation_card.dart';
import 'ngo_donation_header.dart';

class NgoDonationsViewBody extends StatefulWidget {
  const NgoDonationsViewBody({super.key});

  @override
  State<NgoDonationsViewBody> createState() => _NgoDonationsViewBodyState();
}

class _NgoDonationsViewBodyState extends State<NgoDonationsViewBody> {
  final DatabaseService _databaseService = getIt<DatabaseService>();
  final Map<String, String> _userAddresses = {};
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedStatus;
  String? _selectedDateFilter;
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
    super.initState();
    // Get the NGO's UID and listen to their medicines in real-time
    final ngo = getNgo();
    context.read<MedicineCubit>().listenToNgoMedicines(ngo.uId);
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
                  value: _selectedStatus,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  items: [
                    const DropdownMenuItem(value: null, child: Text('All Status')),
                    const DropdownMenuItem(value: 'pending', child: Text('Pending')),
                    const DropdownMenuItem(value: 'approved', child: Text('Approved')),
                    const DropdownMenuItem(value: 'rejected', child: Text('Rejected')),
                    const DropdownMenuItem(value: 'delivered', child: Text('Delivered')),
                  ],
                  onChanged: (value) {
                    setState(() => _selectedStatus = value);
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Date',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedDateFilter,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  items: [
                    const DropdownMenuItem(value: null, child: Text('All Time')),
                    const DropdownMenuItem(value: 'last_week', child: Text('Last Week')),
                    const DropdownMenuItem(value: 'last_month', child: Text('Last Month')),
                    const DropdownMenuItem(value: 'last_3_months', child: Text('Last 3 Months')),
                  ],
                  onChanged: (value) {
                    setState(() => _selectedDateFilter = value);
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
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  items: [
                    const DropdownMenuItem(value: null, child: Text('All')),
                    const DropdownMenuItem(value: 'small', child: Text('Small (< 10)')),
                    const DropdownMenuItem(value: 'medium', child: Text('Medium (10-50)')),
                    const DropdownMenuItem(value: 'large', child: Text('Large (> 50)')),
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
                  _selectedStatus = null;
                  _selectedDateFilter = null;
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

  Future<String> _getUserAddress(String userId) async {
    if (_userAddresses.containsKey(userId)) {
      return _userAddresses[userId]!;
    }

    try {
      final userData = await _databaseService.getData(
        path: BackendEndpoint.getUserData,
        documentId: userId,
      ) as Map<String, dynamic>;

      final address = userData['address'] as String? ?? 'Address not available';
      _userAddresses[userId] = address;
      return address;
    } catch (e) {
      return 'Address not available';
    }
  }

  List<dynamic> _filterMedicines(List<dynamic> medicines) {
    return medicines.where((medicine) {
      // Search query filter
      if (_searchQuery.isNotEmpty) {
        final medicineName = medicine.medicineName.toLowerCase();
        final donorName = medicine.donorName.toLowerCase();
        final query = _searchQuery.toLowerCase();
        
        if (!medicineName.contains(query) && !donorName.contains(query)) {
          return false;
        }
      }

      // Status filter
      if (_selectedStatus != null && medicine.status.toLowerCase() != _selectedStatus!.toLowerCase()) {
        return false;
      }

      // Date filter
      if (_selectedDateFilter != null) {
        final receivedDate = _parseDate(medicine.receivedDate);
        final now = DateTime.now();
        
        switch (_selectedDateFilter) {
          case 'last_week':
            if (receivedDate.isBefore(now.subtract(const Duration(days: 7)))) return false;
            break;
          case 'last_month':
            if (receivedDate.isBefore(now.subtract(const Duration(days: 30)))) return false;
            break;
          case 'last_3_months':
            if (receivedDate.isBefore(now.subtract(const Duration(days: 90)))) return false;
            break;
        }
      }

      // Quantity filter
      if (_selectedQuantityFilter != null) {
        final quantity = int.tryParse(medicine.tabletCount.toString()) ?? 0;
        switch (_selectedQuantityFilter) {
          case 'small':
            if (quantity >= 10) return false;
            break;
          case 'medium':
            if (quantity < 10 || quantity > 50) return false;
            break;
          case 'large':
            if (quantity <= 50) return false;
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
            'Donations',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          DonationsHeader(),
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
            child: BlocBuilder<MedicineCubit, MedicineState>(
              builder: (context, state) {
                if (state is MedicineLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MedicineFailure) {
                  return Center(child: Text(state.errorMessage));
                } else if (state is MedicineSuccess) {
                  final filteredMedicines = _filterMedicines(state.medicines);
                  
                  if (filteredMedicines.isEmpty) {
                    return const Center(
                      child: Text(
                        'No donations found',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                  
                  return ListView.builder(
                    itemCount: filteredMedicines.length,
                    itemBuilder: (context, index) {
                      final medicine = filteredMedicines[index];
                      return FutureBuilder<String>(
                        future: _getUserAddress(medicine.userId),
                        builder: (context, snapshot) {
                          return NgoDonationCard(
                            medicineName: medicine.medicineName,
                            donorName: medicine.donorName,
                            status: medicine.status,
                            statusIcon: DonationStatusUtils.getStatusIcon(_parseStatus(medicine.status)),
                            statusColor: DonationStatusUtils.getStatusColor(_parseStatus(medicine.status)),
                            tabletCount: medicine.tabletCount,
                            purchasedDate: medicine.purchasedDate,
                            expirtDate: medicine.expiryDate,
                            receivedDate: medicine.receivedDate,
                            details: medicine.details,
                            image: medicine.imageUrl,
                            location: snapshot.data ?? 'Loading address...',
                          );
                        },
                      );
                    },
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

DonationStatus _parseStatus(String status) {
  switch (status.toLowerCase()) {
    case 'approved':
      return DonationStatus.approved;
    case 'rejected':
      return DonationStatus.rejected;
    case 'delivered':
      return DonationStatus.delivered;
    case 'pending':
    default:
      return DonationStatus.pending;
  }
}
