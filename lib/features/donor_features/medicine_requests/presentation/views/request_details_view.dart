import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/ngo_features/medicine_requests/domain/entities/medicine_request_entity.dart';
import 'package:graduation_project/features/ngo_features/medicine_requests/presentation/cubits/fulfill_request_cubit/fulfill_request_cubit.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/features/donor_features/add_medicine/presentation/views/add_medicine_view.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';

class RequestDetailsView extends StatelessWidget {
  static const routeName = '/request-details';
  final MedicineRequestEntity request;

  const RequestDetailsView({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FulfillRequestCubit(getIt()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Request Details'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: BlocConsumer<FulfillRequestCubit, FulfillRequestState>(
          listener: (context, state) {
            if (state is FulfillRequestSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Request fulfilled successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            } else if (state is FulfillRequestFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: ${state.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Request Header
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            request.medicineName,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8),
                          _buildInfoRow('NGO', request.ngoName),
                          FutureBuilder(
                            future: getIt<AuthRepo>()
                                .getNgoData(uId: request.ngoUId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox(
                                    height: 8,
                                    child: LinearProgressIndicator());
                              }
                              if (snapshot.hasError || !snapshot.hasData) {
                                return const Text('NGO info unavailable');
                              }
                              final ngo = snapshot.data;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildInfoRow('NGO Address', ngo!.address),
                                  _buildInfoRow('NGO Phone', ngo.phone),
                                ],
                              );
                            },
                          ),
                          _buildInfoRow('Category', request.category),
                          _buildInfoRow('Quantity',
                              '${request.fulfilledQuantity}/${request.quantity}'),
                          _buildInfoRow('Urgency', request.urgency),
                          _buildInfoRow('Status', request.status),
                          if (request.description.isNotEmpty)
                            _buildInfoRow('Description', request.description),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Only show the donation button
                  if (request.status == 'Active') ...[
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () => _navigateToDonation(context),
                        icon: const Icon(Icons.medical_services),
                        label: const Text('Donate Medicine for This Request'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ] else if (request.status == 'Fulfilled') ...[
                    Card(
                      color: Colors.green.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 48,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Request Fulfilled',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            if (request.donorName != null) ...[
                              const SizedBox(height: 8),
                              Text('Fulfilled by: ${request.donorName}'),
                            ],
                            if (request.fulfilledDate != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                  'Date: ${_formatDate(request.fulfilledDate!)}'),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],

                  if (state is FulfillRequestLoading) ...[
                    const SizedBox(height: 24),
                    const Center(child: CircularProgressIndicator()),
                  ],

                  if (request.donations.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    Text('Donation History:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    ...request.donations.map((donation) => ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(donation['donorName'] ?? ''),
                          subtitle: Text('Quantity: ${donation['quantity']}'),
                          trailing: Text(donation['date'] != null
                              ? donation['date'].toString().split('T').first
                              : ''),
                        )),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }


  

  void _navigateToDonation(BuildContext context) {
    Navigator.pushNamed(
      context,
      AddMedicineView.routeName,
      arguments: {
        'ngoName': request.ngoName,
        'ngoUId': request.ngoUId,
        'requestId': request.id,
      },
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}
