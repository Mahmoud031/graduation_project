import 'package:flutter/material.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/domain/repositories/medicine_invnetory_repo.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/cubit/medicine_invnetory_cubit/medicine_inventory_cubit.dart';
import 'charts/medicine_inventory_donations_report.dart';
import 'report_option_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import 'charts/donations_by_category_report.dart';
import 'charts/donor_performance_report.dart';
 
class ReportsViewBody extends StatelessWidget {
  const ReportsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reports',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView(
              children: [
                ReportOptionCard(
                  icon: Icons.show_chart,
                  iconColor: const Color(0xFF23B3A7),
                  title: 'Medicine Inventory Donations',
                  subtitle: 'Visualize all key donation metrics in one place',
                  onTap: () {
                    final ngo = getNgo();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (context) => MedicineInventoryCubit(
                              GetIt.I<MedicineInvnetoryRepo>())
                            ..listenToNgoInventory(ngo.uId),
                          child: const MedicineInventoryDonationsReport(),
                        ),
                      ),
                    );
                  },
                ),
                ReportOptionCard(
                  icon: Icons.category,
                  iconColor: const Color(0xFFF7B84B),
                  title: 'Donations by Category',
                  subtitle: 'Breaks down donations by category',
                  onTap: () {
                    final ngo = getNgo();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (context) => MedicineInventoryCubit(
                              GetIt.I<MedicineInvnetoryRepo>())
                            ..listenToNgoInventory(ngo.uId),
                          child: const DonationsByCategoryReport(),
                        ),
                      ),
                    );
                  },
                ),
                ReportOptionCard(
                  icon: Icons.people,
                  iconColor: const Color(0xFF6B6BD6),
                  title: 'Donor Performance',
                  subtitle:
                      'Track and analyze donor contributions and reliability',
                  onTap: () {
                    final ngo = getNgo();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (context) => MedicineInventoryCubit(
                              GetIt.I<MedicineInvnetoryRepo>())
                            ..listenToNgoInventory(ngo.uId),
                          child: const DonorPerformanceReport(),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
