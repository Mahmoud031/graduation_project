import 'dart:io';

import 'package:graduation_project/features/donor_features/add_medicine/domain/entities/medicine_entity.dart';

class MedicineModel {
  final String medicineName;
  final String tabletCount;
  final String details;
  final String purchasedDate;
  final String expiryDate;
  final File imageFile;
  final String ngoName;
  final String userId;
  String? imageUrl;

  MedicineModel({
    required this.medicineName,
    required this.tabletCount,
    required this.details,
    required this.purchasedDate,
    required this.expiryDate,
    required this.imageFile,
    required this.ngoName,
    required this.userId,
    this.imageUrl,
  });

  factory MedicineModel.fromEntity(MedicineEntity addNewMedicineEntity) {
    return MedicineModel(
      medicineName: addNewMedicineEntity.medicineName,
      tabletCount: addNewMedicineEntity.tabletCount,
      details: addNewMedicineEntity.details,
      purchasedDate: addNewMedicineEntity.purchasedDate,
      expiryDate: addNewMedicineEntity.expiryDate,
      imageFile: addNewMedicineEntity.imageFile,
      ngoName: addNewMedicineEntity.ngoName,
      userId: addNewMedicineEntity.userId,
      imageUrl: addNewMedicineEntity.imageUrl,
    );
  }

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      medicineName: json['medicineName'],
      tabletCount: json['tabletCount'],
      details: json['details'],
      purchasedDate: json['purchasedDate'],
      expiryDate: json['expiryDate'],
      imageFile: File(json['imageUrl']),
      ngoName: json['ngoName'],
      userId: json['userId'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medicineName': medicineName,
      'tabletCount': tabletCount,
      'details': details,
      'purchasedDate': purchasedDate,
      'expiryDate': expiryDate,
      'imageUrl': imageUrl,
      'ngoName': ngoName,
      'userId': userId,
    };
  }

  MedicineEntity toEntity() {
    return MedicineEntity(
      medicineName: medicineName,
      tabletCount: tabletCount,
      details: details,
      purchasedDate: purchasedDate,
      expiryDate: expiryDate,
      imageFile: imageFile,
      ngoName: ngoName,
      userId: userId,
      imageUrl: imageUrl,
    );
  }
}
