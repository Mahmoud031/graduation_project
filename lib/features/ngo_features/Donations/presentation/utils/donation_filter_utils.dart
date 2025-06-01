import 'package:intl/intl.dart';

class DonationFilterUtils {
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

  static List<dynamic> filterDonations({
    required List<dynamic> medicines,
    required String searchQuery,
    String? selectedStatus,
    String? selectedDateFilter,
    String? selectedQuantityFilter,
  }) {
    return medicines.where((medicine) {
      // Search query filter
      if (searchQuery.isNotEmpty) {
        final medicineName = medicine.medicineName.toLowerCase();
        final donorName = medicine.donorName.toLowerCase();
        final query = searchQuery.toLowerCase();
        
        if (!medicineName.contains(query) && !donorName.contains(query)) {
          return false;
        }
      }

      // Status filter
      if (selectedStatus != null && medicine.status.toLowerCase() != selectedStatus.toLowerCase()) {
        return false;
      }

      // Date filter
      if (selectedDateFilter != null) {
        final receivedDate = parseDate(medicine.receivedDate);
        final now = DateTime.now();
        
        switch (selectedDateFilter) {
          case 'last_week':
            if (receivedDate.isBefore(now.subtract(const Duration(days: 7)))) return false;
            break;
          case 'last_month':
            if (receivedDate.isBefore(now.subtract(const Duration(days: 30)))) return false;
            break;
          case 'last_3_months':
            if (receivedDate.isBefore(now.subtract(const Duration(days: 90)))) return false;
            break;
        }
      }

      // Quantity filter
      if (selectedQuantityFilter != null) {
        final quantity = int.tryParse(medicine.tabletCount.toString()) ?? 0;
        switch (selectedQuantityFilter) {
          case 'small':
            if (quantity >= 10) return false;
            break;
          case 'medium':
            if (quantity < 10 || quantity > 50) return false;
            break;
          case 'large':
            if (quantity <= 50) return false;
            break;
        }
      }

      return true;
    }).toList();
  }
} 