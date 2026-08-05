import 'package:get/get.dart';

import '../../../core/helpers/report_id_helper.dart';
import '../../../core/helpers/report_type.dart';
import '../data/models/monthly_bill_report_model.dart';
import '../data/models/report_model.dart';
import '../data/models/summary_report_model.dart';
import '../data/repositories/report_repository.dart';

class ReportService {
  ReportService._();

  static final ReportRepository _repository = Get.find();

  //==========================================================
  // Save Summary Report
  //==========================================================

  static Future<void> saveSummary({
    required SummaryReportModel report,
    required String createdBy,
  }) async {
    final reportModel = ReportModel(
      id: ReportIdHelper.summary(
        companyId: report.company.id,
        monthKey: report.monthKey,
      ),

      reportType: ReportType.summary,

      companyId: report.company.id,
      companyName: report.company.name,

      factoryId: null,
      factoryName: null,

      month: report.month,
      monthKey: report.monthKey,

      billNo: report.billNo,

      totalTrips: report.totalTrips,
      totalAmount: report.totalAmount,

      createdAt: DateTime.now(),

      updatedAt: DateTime.now(),

      createdBy: createdBy,
    );

    await _repository.saveReport(reportModel);
  }

  //==========================================================
  // Save Monthly Report
  //==========================================================

  static Future<void> saveMonthly({
    required MonthlyBillReportModel report,
    required String createdBy,
  }) async {
    final reportModel = ReportModel(
      id: ReportIdHelper.monthly(
        factoryId: report.factory.id,
        monthKey: report.monthKey,
      ),

      reportType: ReportType.monthly,

      companyId: report.factory.companyId,
      companyName: report.factory.companyName,

      factoryId: report.factory.id,
      factoryName: report.factory.name,

      month: report.month,
      monthKey: report.monthKey,

      billNo: report.billNo,

      totalTrips: report.totalTrips,
      totalAmount: report.grandTotal,

      createdAt: DateTime.now(),

      updatedAt: DateTime.now(),

      createdBy: createdBy,
    );

    await _repository.saveReport(reportModel);
  }
}
