import 'package:flutter/material.dart';

class MedicineInventoryUtils {
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'new':
        return Colors.green;
      case 'opened':
        return Colors.orange;
      case 'near expiry':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  static DateTime? parseDate(String dateStr) {
    try {
      final parts = dateStr.split('/');
      if (parts.length == 3) {
        return DateTime(
          int.parse(parts[2]),
          int.parse(parts[1]),
          int.parse(parts[0]),
        );
      }
    } catch (e) {
      print('Error parsing date: $e');
    }
    return null;
  }

  static bool validateDates(
    DateTime? receivedDate,
    DateTime? expiryDate,
    DateTime? productionDate,
    Function(String?) setDateError,
  ) {
    if (receivedDate == null) {
      setDateError('Received date is required');
      return false;
    }

    if (expiryDate == null) {
      setDateError('Expiry date is required');
      return false;
    }

    if (productionDate == null) {
      setDateError('Production date is required');
      return false;
    }

    if (productionDate.isAfter(receivedDate)) {
      setDateError('Production date cannot be after received date');
      return false;
    }

    if (receivedDate.isAfter(expiryDate)) {
      setDateError('Received date cannot be after expiry date');
      return false;
    }

    if (productionDate.isAfter(expiryDate)) {
      setDateError('Production date cannot be after expiry date');
      return false;
    }

    if (expiryDate.isBefore(DateTime.now())) {
      setDateError('Expiry date cannot be in the past');
      return false;
    }

    setDateError(null);
    return true;
  }
} 