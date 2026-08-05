import 'dart:typed_data';

import 'package:lohaghara_carrier/core/formatters/formatter.dart';
import 'package:lohaghara_carrier/features/report/data/models/monthy_bill_record_model.dart';
import 'package:lohaghara_carrier/features/report/services/common/pdf_fonts.dart';
import 'package:lohaghara_carrier/features/report/services/common/pdf_helper.dart';
import 'package:lohaghara_carrier/features/report/services/common/pdf_style.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:lohaghara_carrier/features/report/data/models/monthly_bill_report_model.dart';

class MonthlyBillPdfService {
  MonthlyBillPdfService._();

  //==========================================================
  // Column Width
  //==========================================================

  static const double dateWidth = 55;

  static const double truckWidth = 82;

  static const double fareWidth = 50;

  static const double loadWidth = 42;

  static const double unloadWidth = 42;

  static const double totalWidth = 55;

  static const double pointWidth = 65;

  static const double itemWidth = 40;

  static const double remarksWidth = 70;

  //==========================================================
  // Generate Monthly Bill PDF
  //==========================================================

  static Future<Uint8List> generate(MonthlyBillReportModel report) async {
    await PdfFonts.load();

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,

        margin: PdfStyle.pageMargin,

        header: (context) => _buildHeader(report),

        footer: (context) => PdfHelper.pageFooter(context),

        build: (context) => [
          _buildTable(report),

          PdfHelper.smallGap(8),

          _buildSummary(report),
        ],
      ),
    );

    return pdf.save();
  }

  //==========================================================
  // Table
  //==========================================================

  static pw.Widget _buildTable(MonthlyBillReportModel report) {
    return pw.Table(
      border: PdfStyle.monthlyTableBorder,

      defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,

      columnWidths: {
        0: const pw.FixedColumnWidth(dateWidth),
        1: const pw.FixedColumnWidth(truckWidth),
        2: const pw.FixedColumnWidth(fareWidth),
        3: const pw.FixedColumnWidth(loadWidth),
        4: const pw.FixedColumnWidth(unloadWidth),
        5: const pw.FixedColumnWidth(totalWidth),
        6: const pw.FixedColumnWidth(pointWidth),
        7: const pw.FixedColumnWidth(itemWidth),
        8: const pw.FlexColumnWidth(),
      },

      children: [
        /// Header
        _buildTableHeader(),

        /// Body
        ...report.records.map((record) => _buildTableRow(record)),
      ],
    );
  }

  //==========================================================
  // Summary
  //==========================================================

  static pw.Widget _buildSummary(MonthlyBillReportModel report) {
    return pw.Column(
      children: [
        pw.Table(
          border: PdfStyle.monthlyTableBorder,

          columnWidths: {
            /// Total Trucks
            0: pw.FixedColumnWidth(dateWidth + truckWidth),

            /// Total Amount
            1: pw.FixedColumnWidth(
              fareWidth + loadWidth + unloadWidth + totalWidth,
            ),

            /// Remaining Columns
            2: const pw.FlexColumnWidth(
              unloadWidth + pointWidth + itemWidth + remarksWidth,
            ),
          },

          children: [
            pw.TableRow(
              children: [
                _bodyCell(
                  'Total   ${report.totalTrips.toString()} Trucks',
                  alignment: PdfStyle.monthlyCenter,
                  isBold: true,
                ),

                _bodyCell(
                  'Total    ${PdfHelper.formatMoney(report.grandTotal)}/-',
                  alignment: PdfStyle.monthlyCenter,
                  isBold: true,
                ),

                _bodyCell(' ', alignment: PdfStyle.monthlyCenter),
              ],
            ),
          ],
        ),

        PdfHelper.sectionGap(8),

        PdfHelper.amountInWords(report.amountInWords),
      ],
    );
  }

  //==========================================================
  // Header Cell
  //==========================================================

  static pw.Widget _headerCell(String text) {
    return pw.Container(
      alignment: PdfStyle.monthlyCenter,
      padding: PdfStyle.monthlyCellPadding,

      child: pw.Text(
        text,
        style: PdfStyle.monthlyHeader,
        textAlign: pw.TextAlign.center,
        maxLines: 2,
      ),
    );
  }

  //==========================================================
  // Body Cell
  //==========================================================

  static pw.Widget _bodyCell(
    String text, {
    pw.Alignment alignment = PdfStyle.monthlyLeft,
    bool isBold = false,
    PdfColor? color,
  }) {
    return pw.Container(
      alignment: alignment,
      padding: PdfStyle.monthlyCellPadding,
      child: pw.Text(
        text.isEmpty ? '-' : text,
        textAlign: pw.TextAlign.center,
        maxLines: 1,
        style: (isBold ? PdfStyle.monthlyBodyBold : PdfStyle.monthlyBody)
            .copyWith(color: color ?? PdfStyle.black),
      ),
    );
  }

  //==========================================================
  // Table Header
  //==========================================================

  static pw.TableRow _buildTableHeader() {
    return pw.TableRow(
      children: [
        _headerCell('Date'),

        _headerCell('Truck No'),

        _headerCell('Fare'),

        _headerCell('Load\nDemurrage'),

        _headerCell('Unload\nDemurrage'),

        _headerCell('Total'),

        _headerCell('Unload\nPoint'),

        _headerCell('Item'),

        _headerCell('Remarks'),
      ],
    );
  }

  //==========================================================
  // Table Row
  //==========================================================

  static pw.TableRow _buildTableRow(MonthlyBillRecordModel record) {
    return pw.TableRow(
      children: [
        /// Date
        _bodyCell(
          AppFormatter.formatDate(record.date),
          alignment: PdfStyle.monthlyCenter,
        ),

        /// Truck No
        _bodyCell(record.truckNumber, alignment: PdfStyle.monthlyCenter),

        /// Fare
        _bodyCell(
          '${record.fare.toStringAsFixed(0)}/-',
          alignment: PdfStyle.monthlyCenter,
        ),

        /// Load Demurrage
        _bodyCell(
          record.loadDemurrage == 0
              ? '-'
              : '${record.loadDemurrage.toStringAsFixed(0)}/-',
          alignment: PdfStyle.monthlyCenter,
        ),

        /// Unload Demurrage
        _bodyCell(
          record.unloadDemurrage == 0
              ? '-'
              : '${record.unloadDemurrage.toStringAsFixed(0)}/-',
          alignment: PdfStyle.monthlyCenter,
        ),

        /// Total
        _bodyCell(
          '${record.totalAmount.toStringAsFixed(0)}/-',
          alignment: PdfStyle.monthlyCenter,
        ),

        /// Unload Point
        _bodyCell(record.unloadPoint, alignment: PdfStyle.monthlyCenter),

        /// Item
        _bodyCell(
          record.item,
          alignment: PdfStyle.monthlyCenter,
          color: record.item.trim().toLowerCase() == 'hanger'
              ? PdfColors.red
              : PdfStyle.black,
        ),

        /// Remarks
        _bodyCell(
          record.remarks,
          alignment: PdfStyle.monthlyCenter,
          color: record.remarks.trim().isNotEmpty
              ? PdfColors.red
              : PdfStyle.black,
        ),
      ],
    );
  }

  //==========================================================
  // Header
  //==========================================================

  static pw.Widget _buildHeader(MonthlyBillReportModel report) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: [
        /// Factory Name
        pw.Text(
          report.factory.name,
          style: PdfStyle.monthlyTitle,
          textAlign: pw.TextAlign.center,
        ),

        PdfHelper.smallGap(2),

        /// Month
        pw.Text(
          AppFormatter.formatMonthYear(report.month),
          style: PdfStyle.monthlyMonth,
          textAlign: pw.TextAlign.center,
        ),

        PdfHelper.smallGap(6),

        /// Bill No
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.RichText(
            text: pw.TextSpan(
              children: [
                pw.TextSpan(text: 'Bill No : ', style: PdfStyle.monthlyBillNo),

                pw.TextSpan(
                  text: report.billNo,
                  style: PdfStyle.monthlyBillNo.copyWith(font: PdfFonts.bold),
                ),
              ],
            ),
          ),
        ),

        PdfHelper.smallGap(6),
      ],
    );
  }
}
