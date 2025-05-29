import '../../domain/entities/medicine_invnetory_entity.dart';

class MedicineInvnetoryModel {
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

  MedicineInvnetoryModel(
      {required this.id,
      required this.medicineName,
      required this.category,
      required this.quantityAvailable,
      required this.recievedDate,
      required this.prurchasedDate,
      required this.expiryDate,
      required this.status,
      required this.donorInfo,
      required this.physicalCondition,
      required this.notes});
      factory MedicineInvnetoryModel.fromEntity(
      MedicineInvnetoryEntity medicineInvnetoryEntity) {
    return MedicineInvnetoryModel(
      id: medicineInvnetoryEntity.id,
      medicineName: medicineInvnetoryEntity.medicineName,
      category: medicineInvnetoryEntity.category,
      quantityAvailable: medicineInvnetoryEntity.quantityAvailable,
      recievedDate: medicineInvnetoryEntity.recievedDate,
      prurchasedDate: medicineInvnetoryEntity.prurchasedDate,
      expiryDate: medicineInvnetoryEntity.expiryDate,
      status: medicineInvnetoryEntity.status,
      donorInfo: medicineInvnetoryEntity.donorInfo,
      physicalCondition: medicineInvnetoryEntity.physicalCondition,
      notes: medicineInvnetoryEntity.notes,
    );
  }
  factory MedicineInvnetoryModel.fromJson(Map<String, dynamic> json) {
    return MedicineInvnetoryModel(
      id: json['id'] ?? '',
      medicineName: json['medicineName'],
      category: json['category'],
      quantityAvailable: json['quantityAvailable'],
      recievedDate: json['recievedDate'],
      prurchasedDate: json['prurchasedDate'],
      expiryDate: json['expiryDate'],
      status: json['status'],
      donorInfo: json['donorInfo'],
      physicalCondition: json['physicalCondition'],
      notes: json['notes'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'medicineName': medicineName,
      'category': category,
      'quantityAvailable': quantityAvailable,
      'recievedDate': recievedDate,
      'prurchasedDate': prurchasedDate,
      'expiryDate': expiryDate,
      'status': status,
      'donorInfo': donorInfo,
      'physicalCondition': physicalCondition,
      'notes': notes,
    };
  }
  MedicineInvnetoryEntity toEntity() {
    return MedicineInvnetoryEntity(
      id: id,
      medicineName: medicineName,
      category: category,
      quantityAvailable: quantityAvailable,
      recievedDate: recievedDate,
      prurchasedDate: prurchasedDate,
      expiryDate: expiryDate,
      status: status,
      donorInfo: donorInfo,
      physicalCondition: physicalCondition,
      notes: notes,
    );
  }
}
