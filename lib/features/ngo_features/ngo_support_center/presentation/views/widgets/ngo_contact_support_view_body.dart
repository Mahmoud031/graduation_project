import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/core/widgets/custom_app_bar.dart';
import 'package:graduation_project/core/widgets/custom_button.dart';
import 'package:graduation_project/core/widgets/custom_text_field.dart';

import '../../../domain/entities/ngo_message_entity.dart';
import '../../send_ngo_message_cubit/send_ngo_message_cubit.dart';

class NgoContactSupportViewBody extends StatefulWidget {
  const NgoContactSupportViewBody({super.key});

  @override
  State<NgoContactSupportViewBody> createState() => _NgoContactSupportViewBodyState();
}

class _NgoContactSupportViewBodyState extends State<NgoContactSupportViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String subject, message;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          children: [
            CustomAppBar(
              title: 'Contact Support',
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Send us a message',
                      style: TextStyles.textstyle25.copyWith(
                        color: Colors.black,
                      )),
                  const SizedBox(height: 8),
                  Text(
                    'We\'ll get back to you as soon as possible',
                    style: TextStyles.textstyle16.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Subject', style: TextStyles.textstyle16),
                        const SizedBox(height: 8),
                        CustomTextFormField(
                          hintText: 'Enter subject',
                          prefixIcon: Icons.subject,
                          onSaved: (value) {
                            subject = value ?? '';
                          },
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Message',
                          style: TextStyles.textstyle16,
                        ),
                        const SizedBox(height: 8),
                        CustomTextFormField(
                          hintText: 'Type your message here...',
                          prefixIcon: Icons.message,
                          onSaved: (value) {
                            message = value ?? '';
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'send Message',
                      size: Size(MediaQuery.of(context).size.width * 0.8, 15),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          final currentUser = getNgo();
                          NgoMessageEntity inputMessage = NgoMessageEntity(
                            subject: subject,
                            message: message,
                            ngoId: currentUser.uId,
                            ngoName: currentUser.name,
                          );
                          context
                              .read<SendNgoMessageCubit>()
                              .sendMessage(inputMessage);
                        } else {
                          setState(() {
                            autovalidateMode = AutovalidateMode.always;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
