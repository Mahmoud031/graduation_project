import 'package:flutter/material.dart';

import 'widgets/sign_up_ngo_body_view.dart';

class SignUpNgoView extends StatelessWidget {
  const SignUpNgoView({super.key});
  static const routeName = 'signUpNgoView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const SignUpNgoViewBody());
  }
}
