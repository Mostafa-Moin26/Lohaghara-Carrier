import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String display(DateTime date) =>
      DateFormat('dd MMM yyyy').format(date);

  static String displayWithDay(DateTime date) =>
      DateFormat('EEE, dd MMM yyyy').format(date);

  static String monthYear(DateTime date) =>
      DateFormat('MMMM yyyy').format(date);

  static String forFileName(DateTime date) =>
      DateFormat('yyyyMMdd').format(date);

  static String timeOnly(DateTime date) => DateFormat('hh:mm a').format(date);

  static String relative(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays} days ago';

    return display(date);
  }
}
