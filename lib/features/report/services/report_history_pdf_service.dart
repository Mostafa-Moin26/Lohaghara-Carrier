import 'dart:typed_data';

import 'package:lohaghara_carrier/features/report/services/common/pdf_download_service.dart';
import 'package:lohaghara_carrier/features/report/services/common/pdf_preview_service.dart';
import 'package:lohaghara_carrier/features/report/services/common/pdf_share_service.dart';
import 'package:lohaghara_carrier/features/report/services/monthly_pdf/monthly_bill_pdf_service.dart';
import 'package:lohaghara_carrier/features/report/services/summary_pdf/summary_pdf_service.dart';

import '../../../core/helpers/pdf_file_name_helper.dart';
import '../../../core/helpers/report_type.dart';
import '../../company/data/repositories/company_repository.dart';
import '../../factory/data/models/factory_monthly_model.dart';
import '../../factory/data/repositories/factory_repository.dart';
import '../builders/monthly_report_builder.dart';
import '../builders/summary_report_builder.dart';
import '../data/models/monthy_bill_record_model.dart';
import '../data/models/report_model.dart';
import '../data/repositories/monthly_bill_repository.dart';
import '../data/repositories/summary_repository.dart';

class ReportHistoryPdfService {
  ReportHistoryPdfService._();

  static final MonthlyBillRepository _monthlyRepository =
      MonthlyBillRepository();

  static final SummaryRepository _summaryRepository = SummaryRepository();

  static final FactoryRepository _factoryRepository =
      FactoryRepository.instance;

  static final CompanyRepository _companyRepository =
      CompanyRepository.instance;

  //==========================================================
  // Generate PDF
  //==========================================================

  static Future<Uint8List> _generatePdf(ReportModel report) async {
    switch (report.reportType) {
      case ReportType.monthly:
        return await _generateMonthlyPdf(report);

      case ReportType.summary:
        return await _generateSummaryPdf(report);

      default:
        throw Exception('Unsupported report type: ${report.reportType}');
    }
  }

  //==========================================================
  // Generate Monthly PDF
  //==========================================================

  static Future<Uint8List> _generateMonthlyPdf(ReportModel report) async {
    //----------------------------------------------------------
    // Load Factory
    //----------------------------------------------------------

    final factory = await _factoryRepository.fetchFactoryById(
      report.factoryId!,
    );

    //----------------------------------------------------------
    // Load Monthly Data
    //----------------------------------------------------------

    final results = await Future.wait([
      _monthlyRepository.fetchFactoryMonthly(
        factoryId: report.factoryId!,
        monthKey: report.monthKey,
      ),

      _monthlyRepository.fetchMonthlyRecords(
        factoryId: report.factoryId!,
        monthKey: report.monthKey,
      ),
    ]);

    final factoryMonthly = results[0] as FactoryMonthlyModel;

    final records = results[1] as List<MonthlyBillRecordModel>;

    //----------------------------------------------------------
    // Build Report
    //----------------------------------------------------------

    final monthlyReport = MonthlyReportBuilder.build(
      factory: factory,
      factoryMonthly: factoryMonthly,
      records: records,
      month: report.month,
      monthKey: report.monthKey,
      billNo: report.billNo,
    );

    //----------------------------------------------------------
    // Generate PDF
    //----------------------------------------------------------

    return MonthlyBillPdfService.generate(monthlyReport);
  }

  //==========================================================
  // Generate Summary PDF
  //==========================================================

  static Future<Uint8List> _generateSummaryPdf(ReportModel report) async {
    //----------------------------------------------------------
    // Load Company
    //----------------------------------------------------------

    final company = await _companyRepository.fetchCompanyById(report.companyId);

    //----------------------------------------------------------
    // Load Summary Data
    //----------------------------------------------------------

    final factories = await _summaryRepository.fetchFactorySummary(
      companyId: report.companyId,
      monthKey: report.monthKey,
    );

    //----------------------------------------------------------
    // Build Report
    //----------------------------------------------------------

    final summaryReport = SummaryReportBuilder.build(
      company: company,
      factories: factories,
      month: report.month,
      monthKey: report.monthKey,
      billNo: report.billNo,
    );

    //----------------------------------------------------------
    // Generate PDF
    //----------------------------------------------------------

    return SummaryPdfService.generate(report: summaryReport);
  }

  //==========================================================
  // Preview
  //==========================================================

  static Future<void> preview(ReportModel report) async {
    final pdf = await _generatePdf(report);

    await PdfPreviewService.preview(pdf);
  }

  //==========================================================
  // Download
  //==========================================================

  static Future<void> download(ReportModel report) async {
    final pdf = await _generatePdf(report);

    final fileName = report.reportType == 'monthly'
        ? PdfFileNameHelper.monthly(
            factoryName: report.factoryName!,
            month: report.month,
          )
        : PdfFileNameHelper.summary(
            companyName: report.companyName,
            month: report.month,
          );

    await PdfDownloadService.saveAndOpen(pdfBytes: pdf, fileName: fileName);
  }

  //==========================================================
  // Share
  //==========================================================

  static Future<void> share(ReportModel report) async {
    final pdf = await _generatePdf(report);

    final fileName = report.reportType == 'monthly'
        ? PdfFileNameHelper.monthly(
            factoryName: report.factoryName!,
            month: report.month,
          )
        : PdfFileNameHelper.summary(
            companyName: report.companyName,
            month: report.month,
          );

    await PdfShareService.share(pdfBytes: pdf, fileName: fileName);
  }
}
