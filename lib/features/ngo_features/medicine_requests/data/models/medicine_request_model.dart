import 'package:graduation_project/features/ngo_features/medicine_requests/domain/entities/medicine_request_entity.dart';

class MedicineRequestModel {
  final String id;
  final String medicineName;
  final String description;
  final String quantity;
  final String urgency;
  final String ngoName;
  final String ngoUId;
  final String requestDate;
  final String status;
  final String? fulfilledDonorId;
  final String? fulfilledDate;
  final String category;
  final String? donorName;
  final String fulfilledQuantity;
  final String? expiryDate;
  final List<Map<String, dynamic>> donations;

  MedicineRequestModel({
    required this.id,
    required this.medicineName,
    required this.description,
    required this.quantity,
    required this.urgency,
    required this.ngoName,
    required this.ngoUId,
    required this.requestDate,
    this.status = 'Active',
    this.fulfilledDonorId,
    this.fulfilledDate,
    required this.category,
    this.donorName,
    this.fulfilledQuantity = '0',
    this.expiryDate,
    this.donations = const [],
  });

  factory MedicineRequestModel.fromEntity(MedicineRequestEntity entity) {
    return MedicineRequestModel(
      id: entity.id,
      medicineName: entity.medicineName,
      description: entity.description,
      quantity: entity.quantity,
      urgency: entity.urgency,
      ngoName: entity.ngoName,
      ngoUId: entity.ngoUId,
      requestDate: entity.requestDate,
      status: entity.status,
      fulfilledDonorId: entity.fulfilledDonorId,
      fulfilledDate: entity.fulfilledDate,
      category: entity.category,
      donorName: entity.donorName,
      fulfilledQuantity: entity.fulfilledQuantity,
      expiryDate: entity.expiryDate,
      donations: entity.donations,
    );
  }

  factory MedicineRequestModel.fromJson(Map<String, dynamic> json) {
    return MedicineRequestModel(
      id: json['id'] ?? '',
      medicineName: json['medicineName'] ?? '',
      description: json['description'] ?? '',
      quantity: json['quantity']?.toString() ?? '',
      urgency: json['urgency'] ?? '',
      ngoName: json['ngoName'] ?? '',
      ngoUId: json['ngoUId'] ?? '',
      requestDate: json['requestDate'] ?? '',
      status: json['status'] ?? 'Active',
      fulfilledDonorId: json['fulfilledDonorId'],
      fulfilledDate: json['fulfilledDate'],
      category: json['category'] ?? '',
      donorName: json['donorName'],
      fulfilledQuantity: json['fulfilledQuantity']?.toString() ?? '0',
      expiryDate: json['expiryDate'],
      donations: (json['donations'] as List<dynamic>?)?.map((e) => Map<String, dynamic>.from(e)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'medicineName': medicineName,
      'description': description,
      'quantity': quantity,
      'urgency': urgency,
      'ngoName': ngoName,
      'ngoUId': ngoUId,
      'requestDate': requestDate,
      'status': status,
      'fulfilledDonorId': fulfilledDonorId,
      'fulfilledDate': fulfilledDate,
      'category': category,
      'donorName': donorName,
      'fulfilledQuantity': fulfilledQuantity,
      'expiryDate': expiryDate,
      'donations': donations,
    };
  }

  MedicineRequestEntity toEntity() {
    return MedicineRequestEntity(
      id: id,
      medicineName: medicineName,
      description: description,
      quantity: quantity,
      urgency: urgency,
      ngoName: ngoName,
      ngoUId: ngoUId,
      requestDate: requestDate,
      status: status,
      fulfilledDonorId: fulfilledDonorId,
      fulfilledDate: fulfilledDate,
      category: category,
      donorName: donorName,
      fulfilledQuantity: fulfilledQuantity,
      expiryDate: expiryDate,
      donations: donations,
    );
  }
} 