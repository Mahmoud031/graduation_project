import 'dart:io';

class AddNewMedicineEntity {
  final String medicineName;
  final String tabletCount;
  final String details;
  final String purchasedDate;
  final String expiryDate;
  final File imageFile;
   String? imageUrl;

   AddNewMedicineEntity({
    required this.medicineName,
    required this.tabletCount,
    required this.details,
    required this.purchasedDate,
    required this.expiryDate,
    required this.imageFile,
    this.imageUrl,
  });
}
