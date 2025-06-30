import 'package:flutter/material.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import 'package:graduation_project/features/chat/presentation/views/widgets/chat_list_view_body.dart';

class ChatListView extends StatefulWidget {
  static const String routeName = '/chat-list';
  const ChatListView({super.key});

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  bool _isDonor = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      dynamic user;
      try {
        user = getUser();
        if (user.type != 'NGO') {
          setState(() {
            _isDonor = true;
          });
        } else {
          setState(() {
            _isDonor = false;
          });
        }
      } catch (_) {
        setState(() {
          _isDonor = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: const ChatListViewBody(),
    );
  }
} 