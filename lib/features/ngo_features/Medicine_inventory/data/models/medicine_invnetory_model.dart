import '../../domain/entities/medicine_invnetory_entity.dart';

class MedicineInvnetoryModel {
  final String id;
  final String? documentId;
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
  final String ngoUId;

  MedicineInvnetoryModel({
    required this.id,
    this.documentId,
    required this.medicineName,
    required this.category,
    required this.quantityAvailable,
    required this.recievedDate,
    required this.prurchasedDate,
    required this.expiryDate,
    required this.status,
    required this.donorInfo,
    required this.physicalCondition,
    required this.notes,
    required this.ngoUId,
  });

  factory MedicineInvnetoryModel.fromEntity(MedicineInvnetoryEntity medicineInvnetoryEntity) {
    return MedicineInvnetoryModel(
      id: medicineInvnetoryEntity.id,
      documentId: medicineInvnetoryEntity.documentId,
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
      ngoUId: medicineInvnetoryEntity.ngoUId,
    );
  }

  factory MedicineInvnetoryModel.fromJson(Map<String, dynamic> json) {
    return MedicineInvnetoryModel(
      id: json['id'] ?? '',
      documentId: json['documentId'],
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
      ngoUId: json['ngoUId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      if (documentId != null) 'documentId': documentId,
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
      'ngoUId': ngoUId,
    };
  }

  MedicineInvnetoryEntity toEntity() {
    return MedicineInvnetoryEntity(
      id: id,
      documentId: documentId,
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
      ngoUId: ngoUId,
    );
  }
}
