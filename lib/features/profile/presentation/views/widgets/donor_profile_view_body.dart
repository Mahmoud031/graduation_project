import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/cubits/medicine_cubit/medicine_cubit.dart';
import 'package:graduation_project/core/widgets/custom_app_bar.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import 'package:graduation_project/features/auth/domain/entities/user_entity.dart';
import 'package:graduation_project/features/donor_features/my_donations/presentation/views/my_donations_view.dart';
import 'package:graduation_project/features/donor_features/donation_guide/presentation/views/donation_guide_view.dart';
import 'package:graduation_project/features/donor_features/support_center/presentation/views/support_center_view.dart';

import '../edit_donor_profile_view.dart';

class DonorProfileViewBody extends StatefulWidget {
  const DonorProfileViewBody({super.key});

  @override
  State<DonorProfileViewBody> createState() => _DonorProfileViewBodyState();
}

class _DonorProfileViewBodyState extends State<DonorProfileViewBody> {
  @override
  void initState() {
    super.initState();
    final user = getUser();
    context.read<MedicineCubit>().listenToDonorMedicines(user.uId);
  }

  @override
  Widget build(BuildContext context) {
    final UserEntity user = getUser();
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE3F0FF), Color(0xFFF8F6FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(
              title: 'My Profile',
            ),
            const SizedBox(height: 20),
            _buildProfileHeader(user),
            const SizedBox(height: 24),
            _buildStatisticsGrid(context),
            const SizedBox(height: 24),
            _buildQuickActions(context),
            const SizedBox(height: 24),
            _buildEditProfileButton(context),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(UserEntity user) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 15,
            offset: const Offset(0, 5),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blue.shade100,
            child: Text(
              user.name[0].toUpperCase(),
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            user.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            user.type,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'National ID: ${user.nationalId}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.blueGrey.shade400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsGrid(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<MedicineCubit, MedicineState>(
        builder: (context, state) {
          if (state is MedicineLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MedicineSuccess) {
            final medicines = state.medicines;
            final totalDonations = medicines.length;
            final completedDonations = medicines
                .where((m) => m.status.toLowerCase() == 'delivered')
                .length;
            final pendingDonations = medicines
                .where((m) => m.status.toLowerCase() == 'pending')
                .length;
            final totalTablets = medicines.fold<int>(0, (sum, m) {
              final count = int.tryParse(m.tabletCount) ?? 0;
              return sum + count;
            });

            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _buildStatCard('Total Donations', '$totalDonations',
                    Icons.card_giftcard, Colors.orangeAccent),
                _buildStatCard('Completed', '$completedDonations',
                    Icons.check_circle, Colors.greenAccent.shade400),
                _buildStatCard('Pending', '$pendingDonations',
                    Icons.pending_actions, Colors.blueAccent.shade100),
                _buildStatCard('Total Tablets', '$totalTablets',
                    Icons.medical_services, Colors.purpleAccent.shade100),
              ],
            );
          }

          if (state is MedicineFailure) {
            return Center(
              child: Text(
                'Error: ${state.errorMessage}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return const Center(child: Text('No data available'));
        },
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 4),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 15,
            offset: const Offset(0, 5),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(
                context,
                'My Donations',
                Icons.card_giftcard,
                () => Navigator.pushNamed(context, MyDonationsView.routeName),
                color: Colors.orangeAccent,
              ),
              _buildActionButton(
                context,
                'Donation Guide',
                Icons.menu_book,
                () => Navigator.pushNamed(context, DonationGuideView.routeName),
                color: Colors.greenAccent.shade400,
              ),
              _buildActionButton(
                context,
                'Support',
                Icons.support_agent,
                () => Navigator.pushNamed(context, SupportCenterView.routeName),
                color: Colors.blueAccent.shade100,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap, {
    required Color color,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditProfileButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, EditDonorProfileView.routeName);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
