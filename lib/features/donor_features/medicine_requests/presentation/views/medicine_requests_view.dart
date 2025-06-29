import 'package:flutter/material.dart';
import 'package:graduation_project/features/ngo_features/medicine_requests/domain/entities/medicine_request_entity.dart';
import 'package:graduation_project/features/ngo_features/medicine_requests/domain/repos/medicine_request_repo.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'request_details_view.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';

class MedicineRequestsView extends StatefulWidget {
  static const routeName = 'medicineRequests';
  const MedicineRequestsView({super.key});

  @override
  State<MedicineRequestsView> createState() => _MedicineRequestsViewState();
}

class _MedicineRequestsViewState extends State<MedicineRequestsView> {
  String? _selectedCategory;
  String? _selectedUrgency;

  String _searchText = '';

  final List<String> _categories = [
    'Painkiller',
    'Antibiotic',
    'Cardiac',
    'Antiviral',
    'Antifungal',
    'Other'
  ];
  final List<String> _urgencyLevels = ['Low', 'Medium', 'High', 'Critical'];

  @override
  Widget build(BuildContext context) {
    final repo = getIt<MedicineRequestRepo>();
    return Scaffold(
      appBar: AppBar(title: const Text('Medicine Requests')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search by medicine name',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (val) => setState(() => _searchText = val),
                  ),
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: _selectedCategory,
                  hint: const Text('Category'),
                  items: [null, ..._categories]
                      .map((cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(cat ?? 'All'),
                          ))
                      .toList(),
                  onChanged: (val) => setState(() => _selectedCategory = val),
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: _selectedUrgency,
                  hint: const Text('Urgency'),
                  items: [null, ..._urgencyLevels]
                      .map((urg) => DropdownMenuItem(
                            value: urg,
                            child: Text(urg ?? 'All'),
                          ))
                      .toList(),
                  onChanged: (val) => setState(() => _selectedUrgency = val),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<MedicineRequestEntity>>(
              stream: repo.getMedicineRequestsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                var requests = snapshot.data
                        ?.where((r) => r.status == 'Active')
                        .toList() ??
                    [];
                // Filtering
                if (_selectedCategory != null) {
                  requests = requests
                      .where((r) => r.category == _selectedCategory)
                      .toList();
                }
                if (_selectedUrgency != null) {
                  requests = requests
                      .where((r) => r.urgency == _selectedUrgency)
                      .toList();
                }
                if (_searchText.isNotEmpty) {
                  requests = requests
                      .where((r) => r.medicineName
                          .toLowerCase()
                          .contains(_searchText.toLowerCase()))
                      .toList();
                }
                if (requests.isEmpty) {
                  return const Center(child: Text('No active requests.'));
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: requests.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final req = requests[i];
                    final int fulfilled =
                        int.tryParse(req.fulfilledQuantity) ?? 0;
                    final int total = int.tryParse(req.quantity) ?? 1;
                    final double progress = (fulfilled / total).clamp(0.0, 1.0);
                    return Card(
                      child: ListTile(
                        title: Text(req.medicineName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Urgency: ${req.urgency}'),
                            Text('Category: ${req.category}'),
                            Text('NGO: ${req.ngoName}'),
                            FutureBuilder(
                              future:
                                  getIt<AuthRepo>().getNgoData(uId: req.ngoUId),
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
                                    Text('NGO Address: ${ngo!.address}'),
                                    Text('NGO Phone: ${ngo.phone}'),
                                  ],
                                );
                              },
                            ),
                            if (req.description.isNotEmpty)
                              Text('Note: ${req.description}'),
                            Text(
                                'Quantity: ${req.fulfilledQuantity}/${req.quantity}'),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: LinearProgressIndicator(value: progress),
                            ),
                          ],
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RequestDetailsView(request: req),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
