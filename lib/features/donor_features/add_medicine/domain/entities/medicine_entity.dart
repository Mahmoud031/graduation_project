import 'dart:io';

class MedicineEntity {
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

  MedicineEntity({
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
}
