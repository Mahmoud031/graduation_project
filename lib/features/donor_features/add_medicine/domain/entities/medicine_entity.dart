import 'dart:io';

class MedicineEntity {
  final String medicineName;
  final String tabletCount;
  final String details;
  final String purchasedDate;
  final String expiryDate;
  final File imageFile;
  final String ngoName;
  final String userId;
  final String ngoUId;
  final String donorName;
  String? imageUrl;

  MedicineEntity({
    required this.medicineName,
    required this.tabletCount,
    required this.details,
    required this.purchasedDate,
    required this.expiryDate,
    required this.imageFile,
    required this.ngoName,
    required this.userId,
    required this.ngoUId,
    required this.donorName,
    this.imageUrl,
  });
}
