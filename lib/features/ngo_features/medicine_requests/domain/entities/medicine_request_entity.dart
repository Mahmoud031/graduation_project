class MedicineRequestEntity {
  final String id;
  final String medicineName;
  final String description;
  final String quantity;
  final String urgency; // 'Low', 'Medium', 'High', 'Critical'
  final String ngoName;
  final String ngoUId;
  final String requestDate;
  final String status; // 'Active', 'Fulfilled', 'Expired'
  final String? fulfilledDonorId; // Donor ID who fulfilled the request
  final String? fulfilledDate;
  final String category; // 'Painkiller', 'Antibiotic', 'Cardiac', 'Antiviral', 'Antifungal', 'Other'
  final String? donorName; // Name of donor who fulfilled the request
  final String fulfilledQuantity;
  final String? expiryDate;
  final List<Map<String, dynamic>> donations;

  MedicineRequestEntity({
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

  MedicineRequestEntity copyWith({
    String? id,
    String? medicineName,
    String? description,
    String? quantity,
    String? urgency,
    String? ngoName,
    String? ngoUId,
    String? requestDate,
    String? status,
    String? fulfilledDonorId,
    String? fulfilledDate,
    String? category,
    String? donorName,
    String? fulfilledQuantity,
    String? expiryDate,
    List<Map<String, dynamic>>? donations,
  }) {
    return MedicineRequestEntity(
      id: id ?? this.id,
      medicineName: medicineName ?? this.medicineName,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      urgency: urgency ?? this.urgency,
      ngoName: ngoName ?? this.ngoName,
      ngoUId: ngoUId ?? this.ngoUId,
      requestDate: requestDate ?? this.requestDate,
      status: status ?? this.status,
      fulfilledDonorId: fulfilledDonorId ?? this.fulfilledDonorId,
      fulfilledDate: fulfilledDate ?? this.fulfilledDate,
      category: category ?? this.category,
      donorName: donorName ?? this.donorName,
      fulfilledQuantity: fulfilledQuantity ?? this.fulfilledQuantity,
      expiryDate: expiryDate ?? this.expiryDate,
      donations: donations ?? this.donations,
    );
  }
} 