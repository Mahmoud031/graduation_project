import 'package:flutter/material.dart';
import 'package:graduation_project/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String routeName = 'home_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC2E1E3),
      appBar: AppBar(
        title: const Text(
          'Donation Hub',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              
            },
            icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.black87,
            ),
          ),
          IconButton(
            onPressed: () {
              
            },
            icon: const Icon(
              Icons.person_outline,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: const SafeArea(
        child: HomeViewBody(),
      ),
    );
  }
}
