import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';

class CustomSideBar extends StatelessWidget {
  const CustomSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF071A26),
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xFF071A26),
                        child: Icon(
                          Icons.account_circle_outlined,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Column(
                        children: [
                          Text(
                            'Donors',
                            style: TextStyles.textstyle34.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'admin@gmail.com',
                            style: TextStyles.textstyle18.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 0,
                  child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: MediaQuery.of(context).size.width * 0.09,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            const Divider(
                color: Colors.white24, thickness: 1, indent: 16, endIndent: 16),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  _buildDrawerItem(
                    icon: Icons.medical_services_outlined,
                    title: 'Donate Medicine',
                    onTap: () {},
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  _buildDrawerItem(
                    icon: Icons.receipt_long_outlined,
                    title: 'View Transaction',
                    onTap: () {},
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  _buildDrawerItem(
                    icon: Icons.lock_outline,
                    title: 'Change Password',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Divider(color: Colors.white24),
                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 24,
                    ),
                    title: const Text(
                      'log out',
                      style: TextStyles.textstyle25,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyles.textstyle25.copyWith(
          color: Colors.white,
        ),
      ),
      onTap: onTap,
    );
  }
}
