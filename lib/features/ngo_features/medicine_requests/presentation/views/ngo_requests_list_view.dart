import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/ngo_features/medicine_requests/presentation/cubits/view_requests_cubit/view_requests_cubit.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import 'package:graduation_project/features/ngo_features/medicine_requests/domain/repos/medicine_request_repo.dart';
import 'package:graduation_project/features/ngo_features/medicine_requests/domain/entities/medicine_request_entity.dart';
import 'edit_ngo_medicine_request_view.dart';

class NgoRequestsListView extends StatefulWidget {
  static const routeName = 'ngoRequestsList';
  const NgoRequestsListView({super.key});

  @override
  State<NgoRequestsListView> createState() => _NgoRequestsListViewState();
}

class _NgoRequestsListViewState extends State<NgoRequestsListView> {
  String? _selectedCategory;
  String? _selectedUrgency;
  String _searchText = '';

  final List<String> _categories = [
    'Painkiller', 'Antibiotic', 'Cardiac', 'Antiviral', 'Antifungal', 'Other'
  ];
  final List<String> _urgencyLevels = [
    'Low', 'Medium', 'High', 'Critical'
  ];

  void _deleteRequest(BuildContext context, String requestId) async {
    final repo = getIt<MedicineRequestRepo>();
    // Store a reference to ScaffoldMessenger before async operations
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Request'),
        content: const Text('Are you sure you want to delete this request?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete')),
        ],
      ),
    );
    
    if (!mounted) return;
    
    if (confirmed == true) {
      try {
        await repo.deleteMedicineRequest(requestId);
        if (mounted) {
          scaffoldMessenger.showSnackBar(const SnackBar(content: Text('Request deleted')));
        }
      } catch (e) {
        if (mounted) {
          scaffoldMessenger.showSnackBar(SnackBar(content: Text('Error deleting request: $e')));
        }
      }
    }
  }

  void _editRequest(BuildContext context, MedicineRequestEntity request) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditNgoMedicineRequestView(request: request),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ngo = getNgo();
    return BlocProvider(
      create: (_) => ViewRequestsCubit(getIt())..listenToNgoRequests(ngo.uId),
      child: Scaffold(
        appBar: AppBar(title: const Text('My Medicine Requests')),
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
                    items: [null, ..._categories].map((cat) => DropdownMenuItem(
                      value: cat,
                      child: Text(cat ?? 'All'),
                    )).toList(),
                    onChanged: (val) => setState(() => _selectedCategory = val),
                  ),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
                    value: _selectedUrgency,
                    hint: const Text('Urgency'),
                    items: [null, ..._urgencyLevels].map((urg) => DropdownMenuItem(
                      value: urg,
                      child: Text(urg ?? 'All'),
                    )).toList(),
                    onChanged: (val) => setState(() => _selectedUrgency = val),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<ViewRequestsCubit, ViewRequestsState>(
                builder: (context, state) {
                  if (state is ViewRequestsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ViewRequestsFailure) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else if (state is ViewRequestsSuccess) {
                    var requests = state.requests;
                    if (_selectedCategory != null) {
                      requests = requests.where((r) => r.category == _selectedCategory).toList();
                    }
                    if (_selectedUrgency != null) {
                      requests = requests.where((r) => r.urgency == _selectedUrgency).toList();
                    }
                    if (_searchText.isNotEmpty) {
                      requests = requests.where((r) => r.medicineName.toLowerCase().contains(_searchText.toLowerCase())).toList();
                    }
                    if (requests.isEmpty) {
                      return const Center(child: Text('No requests found.'));
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: requests.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, i) {
                        final req = requests[i];
                        final int fulfilled = int.tryParse(req.fulfilledQuantity) ?? 0;
                        final int total = int.tryParse(req.quantity) ?? 1;
                        final double progress = (fulfilled / total).clamp(0.0, 1.0);
                        return Card(
                          child: ListTile(
                            title: Text(req.medicineName),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Quantity: ${req.fulfilledQuantity}/${req.quantity}'),
                                Text('Urgency: ${req.urgency}'),
                                Text('Category: ${req.category}'),
                                Text('Status: ${req.status}'),
                                if (req.status == 'Fulfilled' && req.donorName != null)
                                  Text('Fulfilled by: ${req.donorName}'),
                                if (req.expiryDate != null)
                                  Text('Expiry: ${req.expiryDate!.split("T")[0]}'),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: LinearProgressIndicator(value: progress),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () => _editRequest(context, req),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _deleteRequest(context, req.id),
                                ),
                              ],
                            ),
                          ),
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
      ),
    );
  }
} 