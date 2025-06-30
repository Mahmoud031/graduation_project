import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/features/chat/domain/repos/chat_repo.dart';
import 'package:graduation_project/features/chat/presentation/cubits/message_cubit/message_cubit.dart';
import 'package:graduation_project/features/chat/presentation/views/widgets/chat_room_view_body.dart';

class ChatRoomView extends StatelessWidget {
  static const String routeName = '/chat-room';
  final String chatId;
  final String otherPartyName;
  const ChatRoomView({super.key, required this.chatId, required this.otherPartyName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(otherPartyName),
      ),
      body: BlocProvider(
        create: (context) => MessageCubit(getIt<ChatRepo>()),
        child: ChatRoomViewBody(chatId: chatId),
      ),
    );
  }
} 