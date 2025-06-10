import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/helper_functions/build_error_bar.dart';
import 'package:graduation_project/core/widgets/success_dialog.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../send_ngo_message_cubit/send_ngo_message_cubit.dart';
import 'ngo_contact_support_view_body.dart';

class NgoContactSupportViewBodyBlocConsumer extends StatelessWidget {
  const NgoContactSupportViewBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendNgoMessageCubit, SendNgoMessageState>(
      listener: (context, state) {
        if (state is SendNgoMessageSuccess) {
          showDialog(
            context: context,
            builder: (context) => SuccessDialog(
              title: 'Message Sent!',
              subtitle:
                  'Your message has been sent successfully. Our support team will get back to you soon.',
            ),
          ).then((_) {
            Navigator.pop(context);
          });
        } else if (state is SendNgoMessageFailure) {
          buildErrorBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
            inAsyncCall: state is SendNgoMessageLoading,
            child: NgoContactSupportViewBody());
      },
    );
  }
}
