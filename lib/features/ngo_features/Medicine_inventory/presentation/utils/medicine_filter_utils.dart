import 'package:intl/intl.dart';

class MedicineFilterUtils {
  static DateTime parseDate(String dateStr) {
    try {
      // Try parsing as dd/MM/yyyy
      final inputFormat = DateFormat('dd/MM/yyyy');
      return inputFormat.parse(dateStr);
    } catch (e) {
      try {
        // Try parsing as yyyy-MM-dd
        return DateTime.parse(dateStr);
      } catch (e) {
        // If both fail, return current date
        return DateTime.now();
      }
    }
  }

  static List<dynamic> filterMedicines({
    required List<dynamic> medicines,
    required String searchQuery,
    String? selectedCategory,
    String? selectedExpiryFilter,
    String? selectedQuantityFilter,
  }) {
    return medicines.where((medicine) {
      // Search query filter
      if (searchQuery.isNotEmpty) {
        final medicineName = medicine.medicineName.toLowerCase();
        final category = medicine.category.toLowerCase();
        final query = searchQuery.toLowerCase();

        if (!medicineName.contains(query) && !category.contains(query)) {
          return false;
        }
      }

      // Category filter
      if (selectedCategory != null && medicine.category != selectedCategory) {
        return false;
      }

      // Expiry filter
      if (selectedExpiryFilter != null) {
        final expiryDate = parseDate(medicine.expiryDate);
        final now = DateTime.now();
        final thirtyDaysFromNow = now.add(const Duration(days: 30));

        switch (selectedExpiryFilter) {
          case 'expired':
            if (expiryDate.isAfter(now)) return false;
            break;
          case 'expiring_soon':
            if (expiryDate.isBefore(now) ||
                expiryDate.isAfter(thirtyDaysFromNow)) return false;
            break;
          case 'valid':
            if (expiryDate.isBefore(now)) return false;
            break;
        }
      }

      // Quantity filter
      if (selectedQuantityFilter != null) {
        final quantity =
            int.tryParse(medicine.quantityAvailable.toString()) ?? 0;
        switch (selectedQuantityFilter) {
          case 'low_stock':
            if (quantity > 10) return false;
            break;
          case 'in_stock':
            if (quantity <= 10) return false;
            break;
        }
      }

      return true;
    }).toList();
  }
} 