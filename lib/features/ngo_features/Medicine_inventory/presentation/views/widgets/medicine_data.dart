class MedicineData {
  String? name;
  String? category;
  int? quantity;
  DateTime? receivedDate;
  DateTime? productionDate;
  DateTime? expiryDate;
  String? status;
  String? donorInfo;
  String? physicalCondition;
  String? notes;

  bool isValid() {
    return name != null &&
        category != null &&
        quantity != null &&
        receivedDate != null &&
        productionDate != null &&
        expiryDate != null &&
        status != null &&
        donorInfo != null &&
        physicalCondition != null;
  }
} 