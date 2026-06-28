import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:lohaghara_carrier/features/report/data/models/summary_report_model.dart';

import 'pdf_fonts.dart';
import 'pdf_helper.dart';
import 'pdf_style.dart';

class TempSummaryPdfService {
  TempSummaryPdfService._();

  static Future<Uint8List> generate({
    required SummaryReportModel report,
  }) async {
    /// Load Fonts
    await PdfFonts.load();

    /// Create PDF
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: PdfStyle.pageMargin,

        footer: PdfHelper.pageFooter,

        build: (context) {
          return [
            _buildHeader(report),

            _buildMainTable(report),
            _buildTotalTable(report),

            PdfHelper.sectionGap(14),

            _buildAmountInWords(report),
          ];
        },
      ),
    );

    return pdf.save();
  }

  //==========================================================
  // Header
  //==========================================================

  static pw.Widget _buildHeader(SummaryReportModel report) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        /// Summary Title
        pw.Center(
          child: pw.Text(
            'Summary ${DateFormat('MMMM yyyy').format(report.month)}',
            style: PdfStyle.summaryTitle,
          ),
        ),

        PdfHelper.smallGap(),

        /// Company Name
        pw.Center(
          child: pw.Text(report.company.name, style: PdfStyle.summaryCompany),
        ),

        PdfHelper.sectionGap(),

        /// Bill No
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text('Bill No : ${report.billNo}', style: PdfStyle.billNo),
        ),

        PdfHelper.sectionGap(),
      ],
    );
  }

  static pw.Widget _buildMainTable(SummaryReportModel report) {
    return pw.Table(
      border: PdfStyle.tableBorder,

      columnWidths: {
        0: const pw.FlexColumnWidth(1.4),
        1: const pw.FlexColumnWidth(2.6),
        2: const pw.FlexColumnWidth(1.3),
        3: const pw.FlexColumnWidth(1.8),
        4: const pw.FlexColumnWidth(1.5),
        5: const pw.FlexColumnWidth(1.7),
      },

      children: [
        _tableHeader(),

        ...report.factories.map(
          (factory) => _factoryRow(
            billNo: report.billNo,
            factoryName: factory.factoryName,
            truckQty: factory.totalTrips,
            amount: factory.totalAmount,
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildTotalTable(SummaryReportModel report) {
    return pw.Table(
      border: PdfStyle.tableBorder,

      columnWidths: {
        // Bill + Factory width
        0: const pw.FlexColumnWidth(4.0),

        // Truck Qty
        1: const pw.FlexColumnWidth(1.3),

        // Amount
        2: const pw.FlexColumnWidth(1.8),

        // Received
        3: const pw.FlexColumnWidth(1.5),

        // Date
        4: const pw.FlexColumnWidth(1.7),
      },

      children: [
        pw.TableRow(
          children: [
            PdfHelper.totalCell('Total', alignment: pw.Alignment.centerLeft),

            PdfHelper.totalCell(
              report.totalTrips.toString(),
              alignment: pw.Alignment.center,
            ),

            PdfHelper.totalCell(
              '${PdfHelper.formatMoney(report.totalAmount)}/-',
              alignment: pw.Alignment.centerRight,
            ),

            PdfHelper.totalCell(''),

            PdfHelper.totalCell(''),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildSummaryTable(SummaryReportModel report) {
    return pw.Table(
      border: PdfStyle.tableBorder,

      columnWidths: {
        0: const pw.FlexColumnWidth(1.4), // Bill
        1: const pw.FlexColumnWidth(2.4), // Factory
        2: const pw.FlexColumnWidth(1.4), // Truck
        3: const pw.FlexColumnWidth(1.8), // Amount
        4: const pw.FlexColumnWidth(1.5), // Received
        5: const pw.FlexColumnWidth(1.6), // Date
      },

      children: [
        /// Header
        _tableHeader(),

        /// Factory Rows
        ...report.factories.map(
          (factory) => _factoryRow(
            billNo: report.billNo,
            factoryName: factory.factoryName,
            truckQty: factory.totalTrips,
            amount: factory.totalAmount,
          ),
        ),
        _totalRow(report),
      ],
    );
  }

  static pw.TableRow _tableHeader() {
    return pw.TableRow(
      children: [
        PdfHelper.tableHeaderCell('Bill'),

        PdfHelper.tableHeaderCell('Factory Name'),

        PdfHelper.tableHeaderCell('Truck Qty'),

        PdfHelper.tableHeaderCell('Amount'),

        PdfHelper.tableHeaderCell('Received'),

        PdfHelper.tableHeaderCell('Date'),
      ],
    );
  }

  static pw.TableRow _factoryRow({
    required String billNo,
    required String factoryName,
    required int truckQty,
    required double amount,
  }) {
    return pw.TableRow(
      children: [
        PdfHelper.tableCell(billNo, alignment: pw.Alignment.center),

        PdfHelper.tableCell(factoryName),

        PdfHelper.tableCell(
          truckQty.toString(),
          alignment: pw.Alignment.center,
        ),

        PdfHelper.tableCell(
          '${PdfHelper.formatMoney(amount)}/-',
          alignment: pw.Alignment.centerRight,
        ),

        PdfHelper.tableCell('0', alignment: pw.Alignment.center),

        PdfHelper.tableCell(''),
      ],
    );
  }

  static pw.TableRow _totalRow(SummaryReportModel report) {
    return pw.TableRow(
      children: [
        /// Bill
        PdfHelper.totalCell('Total', alignment: pw.Alignment.center),

        /// Factory
        PdfHelper.totalCell(''),

        /// Truck Qty
        PdfHelper.totalCell(
          report.totalTrips.toString(),
          alignment: pw.Alignment.center,
        ),

        /// Amount
        PdfHelper.totalCell(
          '${PdfHelper.formatMoney(report.totalAmount)}/-',
          alignment: pw.Alignment.centerRight,
        ),

        /// Received
        PdfHelper.totalCell(''),

        /// Date
        PdfHelper.totalCell(''),
      ],
    );
  }

  //==========================================================
  // Amount In Words
  //==========================================================

  static pw.Widget _buildAmountInWords(SummaryReportModel report) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Taka (In Words):', style: PdfStyle.totalLabel),

        PdfHelper.smallGap(4),

        pw.Text(report.amountInWords, style: PdfStyle.amountInWords),
      ],
    );
  }
}
