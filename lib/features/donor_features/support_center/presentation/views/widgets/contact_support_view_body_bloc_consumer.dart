import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/helper_functions/build_error_bar.dart';
import 'package:graduation_project/features/donor_features/support_center/presentation/send_message_cubit/send_message_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'contact_support_view_body.dart';

class ContactSupportViewBodyBlocConsumer extends StatelessWidget {
  const ContactSupportViewBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendMessageCubit, SendMessageState>(
      listener: (context, state) {
        if (state is SendMessageSuccess) {
           buildErrorBar(context, 'Medicine added successfully');
        } else if (state is SendMessageFailure) {
          buildErrorBar(context, state.errMessage);
        
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
            inAsyncCall: state is SendMessageLoading,
          child: ContactSupportViewBody());
      },
    );
  }
}
