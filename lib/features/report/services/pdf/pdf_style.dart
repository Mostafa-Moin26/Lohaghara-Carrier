import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'pdf_fonts.dart';

class PdfStyle {
  PdfStyle._();

  //==========================================================
  // Colors
  //==========================================================

  static const PdfColor primaryBlue = PdfColors.blue800;
  static const PdfColor primaryPurple = PdfColor.fromInt(0xFF6C5DD3);

  static const PdfColor black = PdfColors.black;
  static const PdfColor grey = PdfColors.grey700;
  static const PdfColor lightGrey = PdfColors.grey300;

  //==========================================================
  // Layout
  //==========================================================

  static const double cellPadding = 6;

  static const pageMargin = pw.EdgeInsets.symmetric(
    horizontal: 28,
    vertical: 24,
  );

  //==========================================================
  // Summary Report
  //==========================================================

  static pw.TextStyle get summaryTitle =>
      pw.TextStyle(font: PdfFonts.bold, fontSize: 22, color: primaryBlue);

  static pw.TextStyle get summaryCompany =>
      pw.TextStyle(font: PdfFonts.bold, fontSize: 18, color: primaryPurple);

  static pw.TextStyle get billNo =>
      pw.TextStyle(font: PdfFonts.bold, fontSize: 12, color: black);

  //==========================================================
  // Monthly Bill
  //==========================================================

  static pw.TextStyle get monthlyFactory =>
      pw.TextStyle(font: PdfFonts.bold, fontSize: 20, color: black);

  static pw.TextStyle get monthlyMonth =>
      pw.TextStyle(font: PdfFonts.regular, fontSize: 15, color: black);

  //==========================================================
  // Table
  //==========================================================

  static pw.TextStyle get tableHeader =>
      pw.TextStyle(font: PdfFonts.bold, fontSize: 11, color: black);

  static pw.TextStyle get tableBody =>
      pw.TextStyle(font: PdfFonts.regular, fontSize: 10, color: black);

  static pw.TextStyle get tableBodyBold =>
      pw.TextStyle(font: PdfFonts.bold, fontSize: 10, color: black);

  //==========================================================
  // Footer
  //==========================================================

  static pw.TextStyle get totalLabel =>
      pw.TextStyle(font: PdfFonts.regular, fontSize: 12, color: black);

  static pw.TextStyle get amountInWords =>
      pw.TextStyle(font: PdfFonts.regular, fontSize: 11, color: black);

  static pw.TextStyle get pageNumber =>
      pw.TextStyle(font: PdfFonts.regular, fontSize: 10, color: grey);

  //==========================================================
  // Borders
  //==========================================================

  static const double borderWidth = .6;

  static const PdfColor borderColor = PdfColors.black;

  /// For pw.Table
  static final pw.TableBorder tableBorder = pw.TableBorder.all(
    color: borderColor,
    width: borderWidth,
  );

  /// For pw.Container
  static final pw.Border cellBorder = pw.Border.all(
    color: borderColor,
    width: borderWidth,
  );
}
