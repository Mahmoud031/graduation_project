import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/auth/presentation/cubits/ngo_signup_cubit/ngo_signup_cubit.dart';

class NgoSignupHandler {
  final BuildContext context;
  final GlobalKey<FormState> formKey;
  final bool isChecked;
  final String email;
  final String password;
  final String name;
  final String phone;
  final String ngoId;
  final String address;

  NgoSignupHandler({
    required this.context,
    required this.formKey,
    required this.isChecked,
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.ngoId,
    required this.address,
  });

  void handleSignUp() {
  

    context.read<NgoSignupCubit>().createNgoWithEmailAndPassword(
          email: email,
          password: password,
          name: name,
          phone: phone,
          ngoId: ngoId,
          address: address,
        );
  }
} 