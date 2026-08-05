import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

import 'pdf_style.dart';

class PdfHelper {
  PdfHelper._();

  //==========================================================
  // Spacing
  //==========================================================

  static pw.SizedBox sectionGap([double height = 16]) =>
      pw.SizedBox(height: height);

  static pw.SizedBox smallGap([double height = 8]) =>
      pw.SizedBox(height: height);

  //==========================================================
  // Divider
  //==========================================================

  static pw.Divider divider() {
    return pw.Divider(thickness: .8);
  }

  //==========================================================
  // Money Formatter
  //==========================================================

  static String formatMoney(num amount) {
    final formatter = NumberFormat('#,##,##0');

    return formatter.format(amount);
  }

  //==========================================================
  // Header Cell
  //==========================================================

  static pw.Widget tableHeaderCell(
    String text, {
    pw.Alignment alignment = pw.Alignment.center,
  }) {
    return pw.Container(
      alignment: alignment,
      padding: const pw.EdgeInsets.all(6),
      decoration: pw.BoxDecoration(border: PdfStyle.cellBorder),
      child: pw.Text(
        text,
        style: PdfStyle.tableHeader,
        textAlign: pw.TextAlign.center,
      ),
    );
  }

  //==========================================================
  // Body Cell
  //==========================================================

  static pw.Widget tableCell(
    String text, {
    pw.Alignment alignment = pw.Alignment.centerLeft,
    pw.TextStyle? style,
  }) {
    return pw.Container(
      height: 24,
      alignment: alignment,
      padding: const pw.EdgeInsets.all(6),
      decoration: pw.BoxDecoration(border: PdfStyle.cellBorder),
      child: pw.Text(text, style: style ?? PdfStyle.tableBody),
    );
  }

  //==========================================================
  // Total Cell
  //==========================================================

  static pw.Widget totalCell(
    String text, {
    pw.Alignment alignment = pw.Alignment.center,
  }) {
    return pw.Container(
      height: 24,
      alignment: alignment,
      padding: const pw.EdgeInsets.all(6),
      decoration: pw.BoxDecoration(border: PdfStyle.cellBorder),
      child: pw.Text(text, style: PdfStyle.tableBodyBold),
    );
  }

  //==========================================================
  // Amount In Words
  //==========================================================

  static pw.Widget amountInWords(String text) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // divider(),
        sectionGap(8),

        pw.Text('Taka (In Words): $text', style: PdfStyle.amountInWords),

        smallGap(4),

        // pw.Text(text, style: PdfStyle.amountInWords),
      ],
    );
  }

  //==========================================================
  // Page Footer
  //==========================================================

  static pw.Widget pageFooter(pw.Context context) {
    return pw.Align(
      alignment: pw.Alignment.centerRight,
      child: pw.Text(
        'Page ${context.pageNumber} of ${context.pagesCount}',
        style: PdfStyle.pageNumber,
      ),
    );
  }
}
