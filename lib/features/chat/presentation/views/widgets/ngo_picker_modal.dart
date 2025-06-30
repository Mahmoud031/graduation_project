import 'package:flutter/material.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/core/services/database_service.dart';
import 'package:graduation_project/core/utils/backend_endpoint.dart';
import 'package:graduation_project/features/auth/data/models/ngo_model.dart';

class NgoPickerModal extends StatefulWidget {
  const NgoPickerModal({super.key});

  @override
  State<NgoPickerModal> createState() => _NgoPickerModalState();
}

class _NgoPickerModalState extends State<NgoPickerModal> {
  List<NgoModel> _ngos = [];
  List<NgoModel> _filteredNgos = [];
  bool _loading = true;
  String _search = '';

  @override
  void initState() {
    super.initState();
    _fetchNgos();
  }

  Future<void> _fetchNgos() async {
    final db = getIt<DatabaseService>();
    final data = await db.getData(path: BackendEndpoint.getNgoData);
    setState(() {
      _ngos = (data as List).map((e) => NgoModel.fromJson(e)).toList();
      _filteredNgos = _ngos;
      _loading = false;
    });
  }

  void _onSearch(String value) {
    setState(() {
      _search = value;
      _filteredNgos = _ngos.where((ngo) =>
        ngo.name.toLowerCase().contains(value.toLowerCase()) ||
        ngo.email.toLowerCase().contains(value.toLowerCase())
      ).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: 500,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text('Select an NGO to chat with', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 12),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Search NGO by name or email',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: _onSearch,
              ),
              const SizedBox(height: 12),
              Expanded(
                child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredNgos.isEmpty
                    ? const Center(child: Text('No NGOs found'))
                    : ListView.builder(
                        itemCount: _filteredNgos.length,
                        itemBuilder: (context, index) {
                          final ngo = _filteredNgos[index];
                          return ListTile(
                            leading: CircleAvatar(child: Text(ngo.name.isNotEmpty ? ngo.name[0].toUpperCase() : '?')),
                            title: Text(ngo.name),
                            subtitle: Text(ngo.email),
                            onTap: () {
                              Navigator.pop(context, ngo);
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
} 