import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/cubits/medicine_cubit/medicine_cubit.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import 'package:graduation_project/core/services/database_service.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/core/utils/backend_endpoint.dart';
import 'package:graduation_project/core/widgets/summary_card.dart';
import 'ngo_donation_card.dart';
import 'ngo_donation_header.dart';

class NgoDonationsViewBody extends StatefulWidget {
  const NgoDonationsViewBody({super.key});

  @override
  State<NgoDonationsViewBody> createState() => _NgoDonationsViewBodyState();
}

class _NgoDonationsViewBodyState extends State<NgoDonationsViewBody> {
  final DatabaseService _databaseService = getIt<DatabaseService>();
  Map<String, String> _userAddresses = {};

  @override
  void initState() {
    super.initState();
    // Get the NGO's UID and fetch their medicines
    final ngo = getNgo();
    context.read<MedicineCubit>().getMedicineByNgoUId(ngo.uId);
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
            child: BlocBuilder<MedicineCubit, MedicineState>(
              builder: (context, state) {
                if (state is MedicineLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MedicineFailure) {
                  return Center(child: Text(state.errorMessage));
                } else if (state is MedicineSuccess) {
                  return ListView.builder(
                    itemCount: state.medicines.length,
                    itemBuilder: (context, index) {
                      final medicine = state.medicines[index];
                      return FutureBuilder<String>(
                        future: _getUserAddress(medicine.userId),
                        builder: (context, snapshot) {
                          return NgoDonationCard(
                            medicineName: medicine.medicineName,
                            donorName: medicine.donorName,
                            status: "completed",
                            statusIcon: Icons.check,
                            statusColor: Colors.green,
                            tabletCount: medicine.tabletCount,
                            purchasedDate: medicine.purchasedDate,
                            expirtDate: medicine.expiryDate,
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
