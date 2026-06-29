import 'package:intl/intl.dart';

class PdfFileNameHelper {
  PdfFileNameHelper._();

  //==========================================================
  // Summary Report
  // Example:
  // Summary_June_2026_Meghna_Executive_Holding.pdf
  //==========================================================

  static String summary({
    required String companyName,
    required DateTime month,
  }) {
    final monthName = DateFormat('MMMM_yyyy').format(month);

    return 'Summary_${monthName}_${_sanitize(companyName)}.pdf';
  }

  //==========================================================
  // Monthly Factory Bill
  // Example:
  // Monthly_June_2026_Mkcl.pdf
  //==========================================================

  static String monthly({
    required String factoryName,
    required DateTime month,
  }) {
    final monthName = DateFormat('MMMM_yyyy').format(month);

    return 'Monthly_${monthName}_${_sanitize(factoryName)}.pdf';
  }

  //==========================================================
  // Sanitize File Name
  //==========================================================

  static String _sanitize(String text) {
    return text
        .trim()
        .replaceAll('&', 'And')
        .replaceAll(RegExp(r'[\\/:*?"<>|]'), '')
        .replaceAll(RegExp(r'\s+'), '_');
  }
}
