import 'package:flutter/material.dart';

class MedicineFormService {
  DateTime? _purchasedDate;
  DateTime? _expiryDate;
  String? _expiryError;

  // Getters
  DateTime? get purchasedDate => _purchasedDate;
  DateTime? get expiryDate => _expiryDate;
  String? get expiryError => _expiryError;

  Future<void> selectDate(BuildContext context, bool isPurchasedDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      _handleDateSelection(picked, isPurchasedDate);
    }
  }

  void _handleDateSelection(DateTime picked, bool isPurchasedDate) {
    if (isPurchasedDate) {
      _purchasedDate = picked;
      _validateExpiryDateAfterPurchase();
    } else {
      _expiryDate = picked;
      _validateExpiryDate();
    }
  }

  void _validateExpiryDateAfterPurchase() {
    if (_expiryDate != null && _expiryDate!.isBefore(_purchasedDate!)) {
      _expiryDate = null;
      _expiryError = 'Expiry date cannot be before purchased date';
    }
  }

  void _validateExpiryDate() {
    if (_expiryDate!.isBefore(DateTime.now())) {
      _expiryError = 'Medicine is expired';
    } else if (_purchasedDate != null &&
        _expiryDate!.isBefore(_purchasedDate!)) {
      _expiryError = 'Expiry date cannot be before purchased date';
    } else {
      _expiryError = null;
    }
  }

  void reset() {
    _purchasedDate = null;
    _expiryDate = null;
    _expiryError = null;
  }
} 