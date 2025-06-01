import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/cubits/medicine_cubit/medicine_cubit.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import 'package:graduation_project/core/services/database_service.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/core/utils/backend_endpoint.dart';
import 'donation_management_header.dart';
import 'recieved_donations_card.dart';

class DonationManagementViewBody extends StatefulWidget {
  const DonationManagementViewBody({super.key});

  @override
  State<DonationManagementViewBody> createState() =>
      _DonationManagementViewBodyState();
}

class _DonationManagementViewBodyState
    extends State<DonationManagementViewBody> {
  final DatabaseService _databaseService = getIt<DatabaseService>();
  final Map<String, String> _userAddresses = {};

  @override
  void initState() {
    super.initState();
    // Get the NGO's UID and listen to their medicines in real-time
    final ngo = getNgo();
    context.read<MedicineCubit>().listenToNgoMedicines(ngo.uId);
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
            'Donation Management',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 16),
          DonationManagementHeader(),
          const SizedBox(height: 24),
          Text('Received Donations',
              style: TextStyles.textstyle25.copyWith(color: Colors.black)),
          const SizedBox(height: 12),
          Expanded(
            child: BlocBuilder<MedicineCubit, MedicineState>(
              builder: (context, state) {
                if (state is MedicineLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MedicineSuccess) {
                  return ListView.builder(
                    itemCount: state.medicines.length,
                    itemBuilder: (context, index) {
                      final medicine = state.medicines[index];
                      return FutureBuilder<String>(
                        future: _getUserAddress(medicine.userId),
                        builder: (context, snapshot) {
                          return RecievdDonationsCard(
                            medicineName: medicine.medicineName,
                            donorName: medicine.donorName,
                            address: snapshot.data ?? 'Address not available',
                            expiryDate: medicine.expiryDate,
                            purchasedDate: medicine.purchasedDate,
                            image: medicine.imageUrl ?? '',
                            medicineId: medicine.id,
                            status: medicine.status,
                            details: medicine.details,
                            receivedDate: medicine.receivedDate,
                          );
                        },
                      );
                    },
                  );
                } else if (state is MedicineFailure) {
                  return Center(child: Text(state.errorMessage));
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
