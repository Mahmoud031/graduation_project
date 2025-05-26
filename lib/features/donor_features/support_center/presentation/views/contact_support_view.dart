import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/core/widgets/custom_side_bar.dart';
import 'package:graduation_project/features/donor_features/support_center/domain/repos/message_repo.dart';
import 'package:graduation_project/features/donor_features/support_center/presentation/send_message_cubit/send_message_cubit.dart';
import 'widgets/contact_support_view_body_bloc_consumer.dart';

class ContactSupportView extends StatelessWidget {
  const ContactSupportView({super.key});
  static const String routeName = 'contact_support_view';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => SendMessageCubit(
          getIt.get<MessageRepo>(),
        ),
        child: Scaffold(
          drawer: const CustomSideBar(),
          body: ContactSupportViewBodyBlocConsumer(),
        ),
      ),
    );
  }
}
