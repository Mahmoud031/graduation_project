import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/features/chat/domain/entities/chat_message_entity.dart';
import 'package:graduation_project/features/chat/presentation/cubits/message_cubit/message_cubit.dart';
import 'package:intl/intl.dart';

class ChatRoomViewBody extends StatefulWidget {
  final String chatId;
  const ChatRoomViewBody({super.key, required this.chatId});

  @override
  State<ChatRoomViewBody> createState() => _ChatRoomViewBodyState();
}

class _ChatRoomViewBodyState extends State<ChatRoomViewBody> {
  final TextEditingController _controller = TextEditingController();
  late String _currentUserId;
  late String _currentUserName;
  late String _currentUserType;
  List<ChatMessageEntity> _cachedMessages = [];

  @override
  void initState() {
    super.initState();
    dynamic user;
    try {
      user = getUser();
      _currentUserId = user.uId;
      _currentUserName = user.name;
      // Anyone who is NOT an NGO is considered a donor
      // This includes: Individual, Care Center, Patient, Pharmacies, Wholesalers, Manufacturers
      _currentUserType = user.type != 'NGO' ? 'donor' : 'ngo';
    } catch (_) {
      try {
        user = getNgo();
        _currentUserId = user.uId;
        _currentUserName = user.name;
        _currentUserType = 'ngo';
      } catch (_) {
        _currentUserId = '';
        _currentUserName = '';
        _currentUserType = '';
      }
    }
    context.read<MessageCubit>().listenToMessages(widget.chatId);
    // Mark as read on open
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MessageCubit>().markAsRead(widget.chatId, _currentUserId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<MessageCubit, MessageState>(
            builder: (context, state) {
              if (state is MessagesLoaded) {
                _cachedMessages = state.messages;
                return _buildMessagesList(state.messages);
              } else if (state is MessageLoading && _cachedMessages.isNotEmpty) {
                return _buildMessagesList(_cachedMessages);
              } else if (state is MessageFailure) {
                return const Center(child: Text('Failed to load messages'));
              }
              // Show cached messages for all other states
              return _buildMessagesList(_cachedMessages);
            },
          ),
        ),
        _buildInputBar(context),
      ],
    );
  }

  Widget _buildMessagesList(List<ChatMessageEntity> messages) {
    if (messages.isEmpty) {
      return const Center(child: Text('No messages yet'));
    }
    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[messages.length - 1 - index];
        final isMe = message.senderId == _currentUserId;
        return MessageBubble(
          message: message,
          isMe: isMe,
        );
      },
    );
  }

  Widget _buildInputBar(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  border: OutlineInputBorder(),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
                minLines: 1,
                maxLines: 4,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: Colors.blue),
              onPressed: () => _sendMessage(context),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage(BuildContext context) {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    final message = ChatMessageEntity(
      messageId: DateTime.now().millisecondsSinceEpoch.toString(),
      chatId: widget.chatId,
      senderId: _currentUserId,
      senderName: _currentUserName,
      senderType: _currentUserType,
      message: text,
      timestamp: DateTime.now(),
      status: MessageStatus.sent,
    );
    context.read<MessageCubit>().sendMessage(message);
    _controller.clear();
  }
}

class MessageBubble extends StatelessWidget {
  final ChatMessageEntity message;
  final bool isMe;
  const MessageBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    final statusIcon = _getStatusIcon(message.status);
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue.withOpacity(0.9) : Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isMe ? const Radius.circular(16) : const Radius.circular(4),
            bottomRight: isMe ? const Radius.circular(4) : const Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.message,
              style: TextStyles.textstyle18.copyWith(
                color: isMe ? Colors.white : Colors.black54,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat('HH:mm').format(message.timestamp),
                  style: TextStyles.textstyle18.copyWith(
                    color: isMe ? Colors.white70 : Colors.grey,
                  ),
                ),
                if (isMe) ...[
                  const SizedBox(width: 4),
                  statusIcon,
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getStatusIcon(MessageStatus status) {
    switch (status) {
      case MessageStatus.read:
        return const Icon(Icons.done_all, size: 16, color: Colors.lightBlueAccent);
      case MessageStatus.delivered:
        return const Icon(Icons.done_all, size: 16, color: Colors.grey);
      case MessageStatus.sent:
      default:
        return const Icon(Icons.check, size: 16, color: Colors.grey);
    }
  }
} 