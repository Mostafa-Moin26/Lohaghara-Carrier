class BillNumberHelper {
  BillNumberHelper._();

  /// Business Start Month
  static const int _startYear = 2024;
  static const int _startMonth = 12;

  /// Prefix
  static const String _prefix = 'Lohagara';

  /// Generate Bill Number
  static String generate(DateTime selectedMonth) {
    final start = DateTime(_startYear, _startMonth);

    final totalMonths =
        (selectedMonth.year - start.year) * 12 +
        (selectedMonth.month - start.month);

    if (totalMonths < 0) {
      throw Exception('Selected month cannot be before business start month.');
    }

    final serial = totalMonths + 1;

    return '$_prefix-$serial';
  }
}
