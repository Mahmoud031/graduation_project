import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/features/donor_features/support_center/domain/entities/message_entity.dart';
import 'package:graduation_project/features/ngo_features/ngo_support_center/domain/entities/ngo_message_entity.dart';

abstract class MessageRepo {
 Future<Either<Failure, void>> sendMessage(
      MessageEntity sendMessageEntity);
   Future<Either<Failure, void>> sendNgoMessage(
      NgoMessageEntity sendNgoMessageEntity);
  
}