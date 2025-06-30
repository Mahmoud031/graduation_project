import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/core/services/database_service.dart';
import 'package:graduation_project/core/utils/backend_endpoint.dart';
import 'package:graduation_project/features/chat/data/models/chat_model.dart';
import 'package:graduation_project/features/chat/data/models/chat_message_model.dart';
import 'package:graduation_project/features/chat/domain/entities/chat_entity.dart';
import 'package:graduation_project/features/chat/domain/entities/chat_message_entity.dart';
import 'package:graduation_project/features/chat/domain/repos/chat_repo.dart';

class ChatRepoImpl implements ChatRepo {
  final DatabaseService databaseService;
  
  ChatRepoImpl({required this.databaseService});

  @override
  Future<Either<Failure, List<ChatEntity>>> getChats(String userId, String userType) async {
    try {
      final data = await databaseService.getData(path: BackendEndpoint.chats);
      final List<ChatEntity> chats = [];
      
      for (var chatData in data) {
        if (userType == 'donor' && chatData['donorId'] == userId ||
            userType == 'ngo' && chatData['ngoId'] == userId) {
          chats.add(ChatModel.fromJson(chatData));
        }
      }
      
      // Sort by last message time (newest first)
      chats.sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
      return Right(chats);
    } catch (e) {
      log('Error getting chats: $e');
      return Left(ServerFailure('Failed to get chats: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<ChatMessageEntity>>> getChatMessages(String chatId) async {
    try {
      final data = await databaseService.getData(path: BackendEndpoint.chatMessages);
      final List<ChatMessageEntity> messages = [];
      
      for (var messageData in data) {
        if (messageData['chatId'] == chatId) {
          messages.add(ChatMessageModel.fromJson(messageData));
        }
      }
      
      // Sort by timestamp (oldest first)
      messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      return Right(messages);
    } catch (e) {
      log('Error getting messages: $e');
      return Left(ServerFailure('Failed to get messages: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> sendMessage(ChatMessageEntity message) async {
    try {
      // Add message to chat_messages collection
      await databaseService.addData(
        path: BackendEndpoint.chatMessages,
        data: ChatMessageModel.fromEntity(message).toJson(),
        documentId: message.messageId,
      );
      // Update chat's last message and unread count (no messages field)
      final chatData = await databaseService.getData(
        path: BackendEndpoint.chats,
        documentId: message.chatId,
      );
      if (chatData != null) {
        final currentUnreadCount = chatData['unreadCount'] ?? 0;
        final isLastMessageFromOther = chatData['lastMessageSenderId'] != message.senderId;
        await databaseService.updateData(
          path: BackendEndpoint.chats,
          documentId: message.chatId,
          data: {
            'lastMessage': message.message,
            'lastMessageTime': message.timestamp.toIso8601String(),
            'lastMessageSenderId': message.senderId,
            'unreadCount': isLastMessageFromOther ? currentUnreadCount + 1 : currentUnreadCount,
            'isRead': false,
          },
        );
      }
      return Right(null);
    } catch (e) {
      log('Error sending message: $e');
      return Left(ServerFailure('Failed to send message: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, String>> createChat(String donorId, String donorName, String ngoId, String ngoName) async {
    try {
      final chatId = '${donorId}_${ngoId}_${DateTime.now().millisecondsSinceEpoch}';
      await databaseService.addData(
        path: BackendEndpoint.chats,
        documentId: chatId,
        data: {
          'chatId': chatId,
          'donorId': donorId,
          'donorName': donorName,
          'ngoId': ngoId,
          'ngoName': ngoName,
          'lastMessageTime': DateTime.now().toIso8601String(),
          'lastMessage': '',
          'lastMessageSenderId': '',
          'isRead': true,
          'unreadCount': 0,
        },
      );
      return Right(chatId);
    } catch (e) {
      log('Error creating chat: $e');
      return Left(ServerFailure('Failed to create chat: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> markMessagesAsRead(String chatId, String userId) async {
    try {
      final messages = await getChatMessages(chatId);
      
      messages.fold(
        (failure) => throw Exception(failure.message),
        (messagesList) async {
          for (var message in messagesList) {
            if (message.senderId != userId && message.status != MessageStatus.read) {
              await databaseService.updateData(
                path: BackendEndpoint.chatMessages,
                documentId: message.messageId,
                data: {'status': 'read'},
              );
            }
          }
        },
      );
      
      // Reset unread count for this chat
      await databaseService.updateData(
        path: BackendEndpoint.chats,
        documentId: chatId,
        data: {
          'unreadCount': 0,
          'isRead': true,
        },
      );
      
      return Right(null);
    } catch (e) {
      log('Error marking messages as read: $e');
      return Left(ServerFailure('Failed to mark messages as read: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> updateMessageStatus(String messageId, String status) async {
    try {
      await databaseService.updateData(
        path: BackendEndpoint.chatMessages,
        documentId: messageId,
        data: {'status': status},
      );
      return Right(null);
    } catch (e) {
      log('Error updating message status: $e');
      return Left(ServerFailure('Failed to update message status: ${e.toString()}'));
    }
  }

  @override
  Stream<List<ChatMessageEntity>> listenToMessages(String chatId) {
    return databaseService.listenToCollection(BackendEndpoint.chatMessages).map((data) {
      print('All chat_messages:');
      for (var msg in data) {
        print(msg);
      }
      final filtered = data.where((message) => message['chatId'] == chatId).toList();
      print('Filtered for chatId=$chatId: $filtered');
      final messages = filtered.map((message) => ChatMessageModel.fromJson(message)).toList();
      messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      print('Parsed messages: $messages');
      return messages;
    });
  }

  @override
  Stream<List<ChatEntity>> listenToChats(String userId, String userType) {
    return databaseService.listenToCollection(BackendEndpoint.chats).map((data) {
      final chats = data
          .where((chat) => 
              (userType == 'donor' && chat['donorId'] == userId) ||
              (userType == 'ngo' && chat['ngoId'] == userId))
          .map((chat) => ChatModel.fromJson(chat))
          .toList();
      
      chats.sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
      return chats;
    });
  }

  @override
  Future<Either<Failure, void>> deleteChat(String chatId) async {
    try {
      // First, delete all messages associated with the chat
      final messages = await getChatMessages(chatId);
      messages.fold(
        (failure) => throw Exception(failure.message),
        (messagesList) async {
          for (var message in messagesList) {
            await databaseService.deleteData(
              path: BackendEndpoint.chatMessages,
              documentId: message.messageId,
            );
          }
        },
      );
      // Then, delete the chat itself
      await databaseService.deleteData(
        path: BackendEndpoint.chats,
        documentId: chatId,
      );
      return Right(null);
    } catch (e) {
      log('Error deleting chat: $e');
      return Left(ServerFailure('Failed to delete chat: ${e.toString()}'));
    }
  }
} 