import 'package:flutter/material.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/core/services/database_service.dart';
import 'package:graduation_project/core/utils/backend_endpoint.dart';
import 'package:graduation_project/features/auth/data/models/user_model.dart';

class DonorPickerModal extends StatefulWidget {
  const DonorPickerModal({super.key});

  @override
  State<DonorPickerModal> createState() => _DonorPickerModalState();
}

class _DonorPickerModalState extends State<DonorPickerModal> {
  List<UserModel> _donors = [];
  List<UserModel> _filteredDonors = [];
  bool _loading = true;
  String _search = '';
  String? _selectedDonorType;
  
  // All donor types available in the system
  final List<String> donorTypes = [
    "Individual",
    "Care Center",
    "Patient", 
    "Pharmacies",
    "Wholesalers",
    "Manufacturers"
  ];

  @override
  void initState() {
    super.initState();
    _fetchDonors();
  }

  Future<void> _fetchDonors() async {
    final db = getIt<DatabaseService>();
    final data = await db.getData(path: BackendEndpoint.getUserData);
    setState(() {
      // Filter out users with type 'NGO' - show all other types as donors
      _donors = (data as List)
          .where((user) => user['type'] != 'NGO')
          .map((e) => UserModel.fromJson(e))
          .toList();
      _filteredDonors = _donors;
      _loading = false;
    });
  }

  void _onSearch(String value) {
    setState(() {
      _search = value;
      _filterDonors();
    });
  }

  void _onDonorTypeChanged(String? donorType) {
    setState(() {
      _selectedDonorType = donorType;
      _filterDonors();
    });
  }

  void _filterDonors() {
    setState(() {
      _filteredDonors = _donors.where((donor) {
        // Filter by search term
        final matchesSearch = donor.name.toLowerCase().contains(_search.toLowerCase()) ||
                            donor.email.toLowerCase().contains(_search.toLowerCase());
        
        // Filter by donor type if selected
        final matchesType = _selectedDonorType == null || donor.type == _selectedDonorType;
        
        return matchesSearch && matchesType;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: 600, // Increased height to accommodate filter dropdown
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text('Select a Donor to chat with', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 12),
              
              // Search field
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Search donor by name or email',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: _onSearch,
              ),
              const SizedBox(height: 12),
              
              // Donor type filter dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Filter by Donor Type',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                value: _selectedDonorType,
                items: [
                  const DropdownMenuItem<String>(
                    value: null,
                    child: Text('All Donor Types'),
                  ),
                  ...donorTypes.map((type) => DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  )).toList(),
                ],
                onChanged: _onDonorTypeChanged,
              ),
              const SizedBox(height: 12),
              
              // Results count
              if (!_loading)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    '${_filteredDonors.length} donor${_filteredDonors.length != 1 ? 's' : ''} found',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              
              Expanded(
                child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredDonors.isEmpty
                    ? const Center(child: Text('No donors found'))
                    : ListView.builder(
                        itemCount: _filteredDonors.length,
                        itemBuilder: (context, index) {
                          final donor = _filteredDonors[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: _getDonorTypeColor(donor.type),
                              child: Text(
                                donor.name.isNotEmpty ? donor.name[0].toUpperCase() : '?',
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                            title: Text(donor.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(donor.email),
                                Text(
                                  donor.type,
                                  style: TextStyle(
                                    color: _getDonorTypeColor(donor.type),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.pop(context, donor);
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getDonorTypeColor(String donorType) {
    switch (donorType) {
      case 'Individual':
        return Colors.blue;
      case 'Care Center':
        return Colors.green;
      case 'Patient':
        return Colors.orange;
      case 'Pharmacies':
        return Colors.purple;
      case 'Wholesalers':
        return Colors.teal;
      case 'Manufacturers':
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }
} 