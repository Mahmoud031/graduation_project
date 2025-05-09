import 'package:flutter/material.dart';
import 'package:graduation_project/features/support_center/presentation/views/widgets/contact_support_view_body.dart';

class ContactSupportView extends StatelessWidget {
  const ContactSupportView({super.key});
  static const String routeName = 'contact_support_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContactSupportViewBody(),
    );
  }
}