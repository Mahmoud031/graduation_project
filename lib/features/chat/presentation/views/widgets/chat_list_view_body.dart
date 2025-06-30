import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/helper_functions/build_error_bar.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/features/chat/domain/entities/chat_entity.dart';
import 'package:graduation_project/features/chat/presentation/cubits/chat_cubit/chat_cubit.dart';
import 'package:graduation_project/features/chat/presentation/views/chat_room_view.dart';
import 'package:intl/intl.dart';

import 'ngo_picker_modal.dart';
import 'donor_picker_modal.dart';

class ChatListViewBody extends StatefulWidget {
  const ChatListViewBody({super.key});

  @override
  State<ChatListViewBody> createState() => _ChatListViewBodyState();
}

class _ChatListViewBodyState extends State<ChatListViewBody> {
  late ChatCubit _chatCubit;
  late String _userId;
  late String _userType;

  @override
  void initState() {
    super.initState();
    _chatCubit = context.read<ChatCubit>();
    _initializeUser();
  }

  void _initializeUser() {
    dynamic user;
    try {
      user = getUser();
      _userId = user.uId;
      // Check if user is a donor (any type except NGO) or NGO
      _userType = user.type != 'NGO' ? 'donor' : 'ngo';
      _chatCubit.listenToChats(_userId, _userType);
      return;
    } catch (_) {}
    try {
      user = getNgo();
      _userId = user.uId;
      _userType = 'ngo';
      _chatCubit.listenToChats(_userId, _userType);
      return;
    } catch (_) {}
    // If both fail, handle not logged in
    _userId = '';
    _userType = '';
  }

  // Helper method to get current user data safely
  dynamic _getCurrentUser() {
    if (_userType == 'donor') {
      try {
        final user = getUser();
        // Double-check that the user is actually a donor
        if (user.type == 'NGO') {
          return null; // This shouldn't happen, but safety check
        }
        return user;
      } catch (_) {
        return null;
      }
    } else if (_userType == 'ngo') {
      try {
        return getNgo();
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  // Helper method to show error when user data is missing
  void _showUserDataError() {
    if (context.mounted) {
      buildErrorBar(context, 'Unable to get user data. Please try logging in again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocConsumer<ChatCubit, ChatState>(
          listener: (context, state) {
            if (state is ChatFailure) {
              buildErrorBar(context, state.message);
            } else if (state is ChatCreated) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatRoomView(
                    chatId: state.chatId,
                    otherPartyName: _userType == 'donor' ? 'NGO' : 'Donor',
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            // Show loading state if user is not properly initialized
            if (_userId.isEmpty || _userType.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading user data...'),
                  ],
                ),
              );
            }
            
            if (state is ChatLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ChatsLoaded) {
              if (state.chats.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        size: 80,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No chats yet',
                        style: TextStyles.textstyle18.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _userType == 'donor' 
                          ? 'Start a conversation with an NGO'
                          : 'Start a conversation with a donor',
                        style: TextStyles.textstyle18.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.chats.length,
                itemBuilder: (context, index) {
                  final chat = state.chats[index];
                  final otherPartyName = _userType == 'donor' ? chat.ngoName : chat.donorName;
                  final displayName = otherPartyName.isNotEmpty ? otherPartyName : 'Unknown User';

                  return Dismissible(
                    key: Key(chat.chatId),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirm Delete'),
                            content: Text('Are you sure you want to delete this chat with $displayName?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(false),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(true),
                                child: const Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    onDismissed: (direction) {
                      context.read<ChatCubit>().deleteChat(chat.chatId);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Chat with $displayName deleted')),
                      );
                    },
                    background: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.delete, color: Colors.white),
                          SizedBox(width: 8),
                          Text('Delete', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    child: ChatListTile(chat: chat, userType: _userType),
                  );
                },
              );
            }
            return const Center(child: Text('No chats found'));
          },
        ),
        // Only show floating action button if user is properly initialized
        if (_userId.isNotEmpty && _userType.isNotEmpty)
          Positioned(
            bottom: 24,
            right: 24,
            child: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () async {
                if (_userType == 'donor') {
                  final ngo = await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => const NgoPickerModal(),
                  );
                  if (ngo != null) {
                    final currentUser = _getCurrentUser();
                    if (currentUser != null) {
                      Future.microtask(() {
                        if (context.mounted) {
                          context.read<ChatCubit>().createChat(
                            currentUser.uId, 
                            currentUser.name, 
                            ngo.uId, 
                            ngo.name
                          );
                        }
                      });
                    } else {
                      _showUserDataError();
                    }
                  }
                } else if (_userType == 'ngo') {
                  final donor = await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => const DonorPickerModal(),
                  );
                  if (donor != null) {
                    final currentUser = _getCurrentUser();
                    if (currentUser != null) {
                      Future.microtask(() {
                        if (context.mounted) {
                          context.read<ChatCubit>().createChat(
                            donor.uId, 
                            donor.name, 
                            currentUser.uId, 
                            currentUser.name
                          );
                        }
                      });
                    } else {
                      _showUserDataError();
                    }
                  }
                }
              },
            ),
          ),
      ],
    );
  }
}

class ChatListTile extends StatelessWidget {
  final ChatEntity chat;
  final String userType;

  const ChatListTile({
    super.key,
    required this.chat,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    final otherPartyName = userType == 'donor' ? chat.ngoName : chat.donorName;
    final isLastMessageFromMe = chat.lastMessageSenderId == (userType == 'donor' ? chat.donorId : chat.ngoId);
    
    // Handle empty names gracefully
    final displayName = otherPartyName.isNotEmpty ? otherPartyName : 'Unknown User';
    final avatarText = displayName.isNotEmpty ? displayName[0].toUpperCase() : '?';
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.pushNamed(
              context,
              ChatRoomView.routeName,
              arguments: {
                'chatId': chat.chatId,
                'otherPartyName': displayName,
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                  child: Text(
                    avatarText,
                    style: TextStyles.textstyle18.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: TextStyles.textstyle18.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          if (isLastMessageFromMe)
                            Icon(
                              Icons.check,
                              size: 16,
                              color: chat.isRead ? Colors.blue : Colors.grey,
                            ),
                          if (isLastMessageFromMe) const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              chat.lastMessage.isEmpty ? 'No messages yet' : chat.lastMessage,
                              style: TextStyles.textstyle14.copyWith(
                                color: Colors.grey[600],
                                fontWeight: chat.isRead ? FontWeight.normal : FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat('HH:mm').format(chat.lastMessageTime),
                      style: TextStyles.textstyle14.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    if (chat.unreadCount > 0 && !isLastMessageFromMe)
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(
                          chat.unreadCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 