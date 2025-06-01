class FilterConstants {
  static const List<String> categories = [
    'Painkiller',
    'Antibiotic',
    'Cardiac',
    'Antiviral',
    'Antifungal',
    'Other',
  ];

  static const Map<String, String> expiryFilters = {
    'expired': 'Expired',
    'expiring_soon': 'Expiring Soon',
    'valid': 'Valid',
  };

  static const Map<String, String> quantityFilters = {
    'low_stock': 'Low Stock',
    'in_stock': 'In Stock',
  };
} 