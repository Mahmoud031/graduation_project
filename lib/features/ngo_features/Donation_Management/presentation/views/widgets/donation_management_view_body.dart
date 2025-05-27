import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/cubits/medicine_cubit/medicine_cubit.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import 'package:graduation_project/core/services/database_service.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/core/utils/backend_endpoint.dart';
import '../../../../../../core/widgets/summary_card.dart';
import 'recieved_donations_card.dart';

class DonationManagementViewBody extends StatefulWidget {
  const DonationManagementViewBody({super.key});

  @override
  State<DonationManagementViewBody> createState() => _DonationManagementViewBodyState();
}

class _DonationManagementViewBodyState extends State<DonationManagementViewBody> {
  final DatabaseService _databaseService = getIt<DatabaseService>();
  final Map<String, String> _userAddresses = {};

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
            'Donation Management',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SummaryCard(
                color: Color(0xFF23B3A7),
                count: '20',
                label: 'Total\nShipments',
              ),
              SummaryCard(
                color: Color(0xFF6B6BD6),
                count: '12',
                label: 'Shipments\nin Transit',
              ),
              SummaryCard(
                color: Color(0xFFF7B84B),
                count: '18',
                label: 'Delivered\nShipments',
              ),
              SummaryCard(
                color: Color(0xFFF26A5B),
                count: '5',
                label: 'Cancelled\nShipments',
              ),
            ],
          ),
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
                  if (state.medicines.isEmpty) {
                    return const Center(
                      child: Text('No donations received yet'),
                    );
                  }
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
                            address: snapshot.data ?? 'Loading address...',
                            expiryDate: medicine.expiryDate,
                            purchasedDate: medicine.purchasedDate,
                            image: medicine.imageUrl ?? 'https://media.istockphoto.com/id/1778918997/photo/background-of-a-large-group-of-assorted-capsules-pills-and-blisters.jpg?s=612x612&w=0&k=20&c=G6aeWKN1kHyaTxiNdToVW8_xGY0hcenWYIjjG_xwF_Q=',
                          );
                        },
                      );
                    },
                  );
                } else if (state is MedicineFailure) {
                  return Center(
                    child: Text('Error: ${state.errorMessage}'),
                  );
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
