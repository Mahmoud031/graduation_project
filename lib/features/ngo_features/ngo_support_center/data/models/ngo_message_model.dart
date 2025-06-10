import 'package:graduation_project/features/ngo_features/ngo_support_center/domain/entities/ngo_message_entity.dart';

class NgoMessageModel {
  final String subject;
  final String message;
  final String ngoId;
  final String ngoName;

  NgoMessageModel({
    required this.subject, 
    required this.message,
    required this.ngoId,
    required this.ngoName,
  });

  factory NgoMessageModel.fromEntity(NgoMessageEntity sendNgoMessageEntity) {
    return NgoMessageModel(
      subject: sendNgoMessageEntity.subject,
      message: sendNgoMessageEntity.message,
      ngoId: sendNgoMessageEntity.ngoId,
      ngoName: sendNgoMessageEntity.ngoName,
    );
  }

  factory NgoMessageModel.fromJson(Map<String, dynamic> json) {
    return NgoMessageModel(
      subject: json['subject'],
      message: json['message'],
      ngoId: json['ngoId'],
      ngoName: json['ngoName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'message': message,
      'ngoId': ngoId,
      'ngoName': ngoName,
    };
  }

  NgoMessageEntity toEntity() {
    return NgoMessageEntity(
      subject: subject,
      message: message,
      ngoId: ngoId,
      ngoName: ngoName,
    );
  }
}

