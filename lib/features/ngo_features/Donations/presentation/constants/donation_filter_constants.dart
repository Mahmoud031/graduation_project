class DonationFilterConstants {
  static const Map<String, String> statusFilters = {
    'pending': 'Pending',
    'approved': 'Approved',
    'rejected': 'Rejected',
    'delivered': 'Delivered',
  };

  static const Map<String, String> dateFilters = {
    'last_week': 'Last Week',
    'last_month': 'Last Month',
    'last_3_months': 'Last 3 Months',
  };

  static const Map<String, String> quantityFilters = {
    'small': 'Small (< 10)',
    'medium': 'Medium (10-50)',
    'large': 'Large (> 50)',
  };
} 