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

  static const PdfColor borderColor = PdfColors.black;

  //==========================================================
  // Layout
  //==========================================================

  static const double borderWidth = .6;

  static const double cellPadding = 6;

  static const pageMargin = pw.EdgeInsets.symmetric(
    horizontal: 28,
    vertical: 24,
  );

  //==========================================================
  // Summary Report Styles
  //==========================================================

  static pw.TextStyle get summaryTitle =>
      pw.TextStyle(font: PdfFonts.bold, fontSize: 22, color: primaryBlue);

  static pw.TextStyle get summaryCompany =>
      pw.TextStyle(font: PdfFonts.bold, fontSize: 18, color: primaryPurple);

  static pw.TextStyle get billNo =>
      pw.TextStyle(font: PdfFonts.bold, fontSize: 12, color: black);

  static pw.TextStyle get tableHeader =>
      pw.TextStyle(font: PdfFonts.bold, fontSize: 10, color: black);

  static pw.TextStyle get tableBody =>
      pw.TextStyle(font: PdfFonts.regular, fontSize: 10, color: black);

  static pw.TextStyle get tableBodyBold =>
      pw.TextStyle(font: PdfFonts.bold, fontSize: 10, color: black);

  static pw.TextStyle get totalLabel =>
      pw.TextStyle(font: PdfFonts.regular, fontSize: 12, color: black);

  static pw.TextStyle get amountInWords =>
      pw.TextStyle(font: PdfFonts.regular, fontSize: 11, color: black);

  static pw.TextStyle get pageNumber =>
      pw.TextStyle(font: PdfFonts.regular, fontSize: 10, color: grey);

  static final pw.TableBorder tableBorder = pw.TableBorder.all(
    color: borderColor,
    width: borderWidth,
  );

  static final pw.Border cellBorder = pw.Border.all(
    color: borderColor,
    width: borderWidth,
  );

  //==========================================================
  // Monthly Report Styles
  //==========================================================

  /// Title
  static pw.TextStyle get monthlyTitle =>
      pw.TextStyle(font: PdfFonts.bold, fontSize: 18, color: black);

  static pw.TextStyle get monthlyMonth =>
      pw.TextStyle(font: PdfFonts.regular, fontSize: 13, color: black);

  static pw.TextStyle get monthlyBillNo =>
      pw.TextStyle(font: PdfFonts.bold, fontSize: 9, color: black);

  /// Table
  static pw.TextStyle get monthlyHeader =>
      pw.TextStyle(font: PdfFonts.bold, fontSize: 8, color: black);

  static pw.TextStyle get monthlyBody =>
      pw.TextStyle(font: PdfFonts.regular, fontSize: 7.3, color: black);

  static pw.TextStyle get monthlyBodyBold =>
      pw.TextStyle(font: PdfFonts.bold, fontSize: 7.5, color: black);

  static pw.TextStyle get monthlyAmountWords =>
      pw.TextStyle(font: PdfFonts.regular, fontSize: 8.5, color: black);

  static pw.TextStyle get monthlyPageNumber =>
      pw.TextStyle(font: PdfFonts.regular, fontSize: 8, color: grey);

  /// Monthly Table Border
  static final pw.TableBorder monthlyTableBorder = pw.TableBorder.all(
    color: borderColor,
    width: .5,
  );

  static final pw.Border monthlyCellBorder = pw.Border.all(
    color: borderColor,
    width: .5,
  );

  /// Compact Padding
  static const monthlyCellPadding = pw.EdgeInsets.symmetric(
    horizontal: 2,
    vertical: 3,
  );

  /// Alignment
  static const monthlyLeft = pw.Alignment.centerLeft;
  static const monthlyCenter = pw.Alignment.center;
  static const monthlyRight = pw.Alignment.centerRight;
}
