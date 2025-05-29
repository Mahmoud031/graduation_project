class MedicineInvnetoryEntity {
  final String id;
  final String medicineName;
  final String category;
  final String quantityAvailable;
  final String recievedDate;
  final String prurchasedDate;
  final String expiryDate;
  final String status;
  final String donorInfo;
  final String physicalCondition;
  final String notes;

  MedicineInvnetoryEntity({required this.id, required this.medicineName, required this.category, required this.quantityAvailable, required this.recievedDate, required this.prurchasedDate, required this.expiryDate, required this.status, required this.donorInfo, required this.physicalCondition, required this.notes});
}
