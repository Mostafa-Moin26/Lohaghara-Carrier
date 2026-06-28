import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:lohaghara_carrier/core/helpers/factory_helper.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:lohaghara_carrier/features/report/data/models/summary_report_model.dart';

import 'pdf_fonts.dart';
import 'pdf_helper.dart';
import 'pdf_style.dart';

class SummaryPdfService {
  SummaryPdfService._();

  ///==========================================================
  /// Generate Summary PDF
  ///==========================================================
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

        footer: (context) => PdfHelper.pageFooter(context),

        build: (context) {
          return [
            /// Header
            _buildHeader(report),

            PdfHelper.sectionGap(),

            /// Main Table
            _buildMainTable(report),

            /// Total
            _buildTotalTable(report),

            PdfHelper.sectionGap(16),

            /// Amount In Words
            _buildAmountInWords(report),
          ];
        },
      ),
    );

    return pdf.save();
  }

  ///==========================================================
  /// Header
  ///==========================================================
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

        /// Bill Number
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Text('Bill No : ${report.billNo}', style: PdfStyle.billNo),
          ],
        ),
      ],
    );
  }

  ///==========================================================
  /// Main Table
  ///==========================================================
  static pw.Widget _buildMainTable(SummaryReportModel report) {
    return pw.Table(
      border: PdfStyle.tableBorder,

      columnWidths: {
        0: const pw.FlexColumnWidth(1.3), // Bill
        1: const pw.FlexColumnWidth(1.5), // Factory
        2: const pw.FlexColumnWidth(1.4), // Truck Qty
        3: const pw.FlexColumnWidth(1.8), // Amount
        4: const pw.FlexColumnWidth(1.3), // Received
        5: const pw.FlexColumnWidth(1.4), // Date
      },

      children: [
        /// Header Row
        _tableHeader(),

        /// Factory Rows
        ...report.factories.map(
          (factory) => _factoryRow(
            billNo: report.billNo,
            factoryName: FactoryHelper.generateShortName(factory.factoryName),
            truckQty: factory.totalTrips,
            amount: factory.totalAmount,
          ),
        ),
      ],
    );
  }

  ///==========================================================
  /// Table Header
  ///==========================================================
  static pw.TableRow _tableHeader() {
    return pw.TableRow(
      decoration: const pw.BoxDecoration(color: PdfColors.white),
      children: [
        PdfHelper.tableHeaderCell('Bill', alignment: pw.Alignment.center),

        PdfHelper.tableHeaderCell('Factory', alignment: pw.Alignment.center),

        PdfHelper.tableHeaderCell('Truck Qty', alignment: pw.Alignment.center),

        PdfHelper.tableHeaderCell('Amount', alignment: pw.Alignment.center),

        PdfHelper.tableHeaderCell('Received', alignment: pw.Alignment.center),

        PdfHelper.tableHeaderCell('Date', alignment: pw.Alignment.center),
      ],
    );
  }

  ///==========================================================
  /// Factory Row
  ///==========================================================
  static pw.TableRow _factoryRow({
    required String billNo,
    required String factoryName,
    required int truckQty,
    required double amount,
  }) {
    return pw.TableRow(
      children: [
        PdfHelper.tableCell(billNo, alignment: pw.Alignment.center),

        PdfHelper.tableCell(factoryName, alignment: pw.Alignment.center),

        PdfHelper.tableCell(
          truckQty.toString(),
          alignment: pw.Alignment.center,
        ),

        PdfHelper.tableCell(
          '${PdfHelper.formatMoney(amount)}/-',
          alignment: pw.Alignment.center,
        ),

        PdfHelper.tableCell('0', alignment: pw.Alignment.center),

        PdfHelper.tableCell('', alignment: pw.Alignment.center),
      ],
    );
  }

  ///==========================================================
  /// Total Table
  ///==========================================================
  static pw.Widget _buildTotalTable(SummaryReportModel report) {
    return pw.Table(
      border: PdfStyle.tableBorder,

      columnWidths: {
        /// Bill + Factory
        0: const pw.FlexColumnWidth(2.8),

        /// Truck Qty
        1: const pw.FlexColumnWidth(1.4),

        /// Amount
        2: const pw.FlexColumnWidth(1.8),

        /// Received + Date
        3: const pw.FlexColumnWidth(2.7),
      },

      children: [
        pw.TableRow(
          children: [
            PdfHelper.totalCell('Total', alignment: pw.Alignment.centerRight),

            PdfHelper.totalCell(
              report.totalTrips.toString(),
              alignment: pw.Alignment.centerLeft,
            ),

            PdfHelper.totalCell(
              '${PdfHelper.formatMoney(report.totalAmount)}/-',
              alignment: pw.Alignment.center,
            ),

            PdfHelper.totalCell(''),
          ],
        ),
      ],
    );
  }

  ///==========================================================
  /// Amount In Words
  ///==========================================================
  static pw.Widget _buildAmountInWords(SummaryReportModel report) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // pw.Divider(thickness: .8),
        PdfHelper.smallGap(),

        pw.Text(
          'Taka (In Words): ${report.amountInWords}',
          style: PdfStyle.totalLabel,
        ),
      ],
    );
  }
}
