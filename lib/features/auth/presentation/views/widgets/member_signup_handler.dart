import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/auth/presentation/cubits/signp_cubit/signup_cubit.dart';

class MemberSignupHandler {
  final BuildContext context;
  final GlobalKey<FormState> formKey;
  final bool isChecked;
  
  final String password;
  final String email;
  final String name;
  final String phone;
  final String nationalId;
  final String address;
  final String type;
  final int age;

  MemberSignupHandler({
    required this.context,
    required this.formKey,
    required this.isChecked,
    
    required this.password,
    required this.email,
    required this.name,
    required this.phone,
    required this.nationalId,
    required this.address,
    required this.type,
    required this.age,
  });

  void handleSignUp() {
    context.read<SignupCubit>().createUserWithEmailAndPassword(
          email: email,
          password: password,
          name: name,
          phone: phone,
          nationalId: nationalId,
          address: address,
          type: type,
          age: age,
        );
  }
} 