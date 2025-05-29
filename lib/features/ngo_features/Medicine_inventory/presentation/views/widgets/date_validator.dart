class DateValidator {
  static String? validateReceivedDate({
    required DateTime? receivedDate,
    required DateTime? expiryDate,
    required DateTime? productionDate,
  }) {
    if (receivedDate == null) return 'Please select received date';
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    if (receivedDate.isAfter(today)) {
      return 'Received date cannot be in the future';
    }
    
    if (expiryDate != null && receivedDate.isAfter(expiryDate)) {
      return 'Received date cannot be after expiry date';
    }
    
    if (productionDate != null && productionDate.isAfter(receivedDate)) {
      return 'Received date cannot be before production date';
    }
    
    return null;
  }

  static String? validateExpiryDate({
    required DateTime? expiryDate,
    required DateTime? receivedDate,
    required DateTime? productionDate,
  }) {
    if (expiryDate == null) return 'Please select expiry date';
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    if (expiryDate.isBefore(today)) {
      return 'Expiry date cannot be in the past';
    }
    
    if (receivedDate != null && receivedDate.isAfter(expiryDate)) {
      return 'Expiry date cannot be before received date';
    }
    
    if (productionDate != null && productionDate.isAfter(expiryDate)) {
      return 'Expiry date cannot be before production date';
    }
    
    return null;
  }

  static String? validateProductionDate({
    required DateTime? productionDate,
    required DateTime? receivedDate,
    required DateTime? expiryDate,
  }) {
    if (productionDate == null) return null; // Optional field
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    if (productionDate.isAfter(today)) {
      return 'Production date cannot be in the future';
    }
    
    if (receivedDate != null && productionDate.isAfter(receivedDate)) {
      return 'Production date cannot be after received date';
    }
    
    if (expiryDate != null && productionDate.isAfter(expiryDate)) {
      return 'Production date cannot be after expiry date';
    }
    
    return null;
  }
} 