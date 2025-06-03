import 'dart:io';

import 'package:graduation_project/features/donor_features/add_medicine/domain/entities/medicine_entity.dart';

class MedicineModel {
  final String id;
  final String medicineName;
  final String tabletCount;
  final String details;
  final String purchasedDate;
  final String expiryDate;
  final String receivedDate;
  final File imageFile;
  final String ngoName;
  final String userId;
  final String ngoUId;
  final String donorName;
  String? imageUrl;
  String status;
  String? rejectionMessage;

  MedicineModel({
    required this.id,
    required this.medicineName,
    required this.tabletCount,
    required this.details,
    required this.purchasedDate,
    required this.expiryDate,
    required this.receivedDate,
    required this.imageFile,
    required this.ngoName,
    required this.userId,
    required this.ngoUId,
    required this.donorName,
    this.imageUrl,
    this.status = 'pending',
    this.rejectionMessage,
  });

  factory MedicineModel.fromEntity(MedicineEntity addNewMedicineEntity) {
    return MedicineModel(
      id: addNewMedicineEntity.id,
      medicineName: addNewMedicineEntity.medicineName,
      tabletCount: addNewMedicineEntity.tabletCount,
      details: addNewMedicineEntity.details,
      purchasedDate: addNewMedicineEntity.purchasedDate,
      expiryDate: addNewMedicineEntity.expiryDate,
      receivedDate: addNewMedicineEntity.receivedDate,
      imageFile: addNewMedicineEntity.imageFile,
      ngoName: addNewMedicineEntity.ngoName,
      userId: addNewMedicineEntity.userId,
      ngoUId: addNewMedicineEntity.ngoUId,
      donorName: addNewMedicineEntity.donorName,
      imageUrl: addNewMedicineEntity.imageUrl,
      status: addNewMedicineEntity.status,
      rejectionMessage: addNewMedicineEntity.rejectionMessage,
    );
  }

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      id: json['id'] ?? '',
      medicineName: json['medicineName'],
      tabletCount: json['tabletCount'],
      details: json['details'],
      purchasedDate: json['purchasedDate'],
      expiryDate: json['expiryDate'],
      receivedDate: json['receivedDate'],
      imageFile: File(json['imageUrl']),
      ngoName: json['ngoName'],
      userId: json['userId'],
      ngoUId: json['ngoUId'],
      donorName: json['donorName'],
      imageUrl: json['imageUrl'],
      status: json['status'] ?? 'pending',
      rejectionMessage: json['rejectionMessage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'medicineName': medicineName,
      'tabletCount': tabletCount,
      'details': details,
      'purchasedDate': purchasedDate,
      'expiryDate': expiryDate,
      'receivedDate': receivedDate,
      'imageUrl': imageUrl,
      'ngoName': ngoName,
      'userId': userId,
      'ngoUId': ngoUId,
      'donorName': donorName,
      'status': status,
      'rejectionMessage': rejectionMessage,
    };
  }

  MedicineEntity toEntity() {
    return MedicineEntity(
      id: id,
      medicineName: medicineName,
      tabletCount: tabletCount,
      details: details,
      purchasedDate: purchasedDate,
      expiryDate: expiryDate,
      receivedDate: receivedDate,
      imageFile: imageFile,
      ngoName: ngoName,
      userId: userId,
      ngoUId: ngoUId,
      donorName: donorName,
      imageUrl: imageUrl,
      status: status,
      rejectionMessage: rejectionMessage,
    );
  }
}
