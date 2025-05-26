import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/core/services/database_service.dart';
import 'package:graduation_project/core/utils/backend_endpoint.dart';
import 'package:graduation_project/features/donor_features/support_center/data/models/message_model.dart';
import 'package:graduation_project/features/donor_features/support_center/domain/entities/message_entity.dart';
import 'package:graduation_project/features/donor_features/support_center/domain/repos/message_repo.dart';

class MessageRepoImp implements MessageRepo{
  final DatabaseService databaseService;

  MessageRepoImp({required this.databaseService});
  @override
  Future<Either<Failure, void>> sendMessage(MessageEntity sendMessageEntity) async{
     try {
      await databaseService.addData(
          path: BackendEndpoint.sendMessage,
          data: MessageModel.fromEntity(sendMessageEntity).toJson());
      return Right(null);
    } catch (e) {
      log('Error sending Message: $e');
      return Left(ServerFailure('Failed to send message: ${e.toString()}'));
    }
  }
}