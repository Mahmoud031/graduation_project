import 'dart:io';

import 'package:graduation_project/features/add_medicine/domain/entities/add_new_medicine_entity.dart';

class AddNewMedicineModel {
  final String medicineName;
  final String tabletCount;
  final String details;
  final String purchasedDate;
  final String expiryDate;
  final File imageFile;
   String? imageUrl;

   AddNewMedicineModel({
    required this.medicineName,
    required this.tabletCount,
    required this.details,
    required this.purchasedDate,
    required this.expiryDate,
    required this.imageFile,
    this.imageUrl,
  });

  factory AddNewMedicineModel.fromEntity(
      AddNewMedicineEntity addNewMedicineEntity) {
    return AddNewMedicineModel(
      medicineName: addNewMedicineEntity.medicineName,
      tabletCount: addNewMedicineEntity.tabletCount,
      details: addNewMedicineEntity.details,
      purchasedDate: addNewMedicineEntity.purchasedDate,
      expiryDate: addNewMedicineEntity.expiryDate,
      imageFile: addNewMedicineEntity.imageFile,
      imageUrl: addNewMedicineEntity.imageUrl,
    );

  } 
  toJson() {
    return {
      'medicineName': medicineName,
      'tabletCount': tabletCount,
      'details': details,
      'purchasedDate': purchasedDate,
      'expiryDate': expiryDate,
      'imageUrl': imageUrl,
    };
  }
}
