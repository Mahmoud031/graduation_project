int extractLeadingNumber(String value) {
  final match = RegExp(r'^(\d+)').firstMatch(value.trim());
  if (match != null) {
    return int.tryParse(match.group(1)!) ?? 0;
  }
  return 0;
} 