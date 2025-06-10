import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/features/donor_features/support_center/domain/repos/message_repo.dart';

import '../send_ngo_message_cubit/send_ngo_message_cubit.dart';
import 'widgets/ngo_contact_support_view_body_bloc_consumer.dart';

class NgoContactSupportView extends StatelessWidget {
  const NgoContactSupportView({super.key});
  static const String routeName = 'ngoContactSupportView';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => SendNgoMessageCubit(
           getIt.get<MessageRepo>(),
        ),
        child: Scaffold(
          body: const NgoContactSupportViewBodyBlocConsumer(),
        ),
      ),
    );
  }
}
