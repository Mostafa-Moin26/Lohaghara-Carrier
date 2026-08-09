import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:lohaghara_carrier/core/helpers/bill_number_helper.dart';
import 'package:lohaghara_carrier/core/helpers/month_picker_helper.dart';
import 'package:lohaghara_carrier/core/helpers/pdf_file_name_helper.dart';
import 'package:lohaghara_carrier/features/company/data/models/company_model.dart';
import 'package:lohaghara_carrier/features/company/data/repositories/company_repository.dart';

import 'package:lohaghara_carrier/features/factory/data/models/factory_model.dart';
import 'package:lohaghara_carrier/features/factory/data/models/factory_monthly_model.dart';
import 'package:lohaghara_carrier/features/factory/data/repositories/factory_repository.dart';

import 'package:lohaghara_carrier/features/report/data/models/monthly_bill_report_model.dart';
import 'package:lohaghara_carrier/features/report/data/models/monthy_bill_record_model.dart';

import 'package:lohaghara_carrier/features/report/data/repositories/monthly_bill_repository.dart';
import 'package:lohaghara_carrier/features/report/services/common/pdf_download_service.dart';
import 'package:lohaghara_carrier/features/report/services/common/pdf_preview_service.dart';
import 'package:lohaghara_carrier/features/report/services/common/pdf_share_service.dart';
import 'package:lohaghara_carrier/features/report/services/monthly_pdf/monthly_bill_pdf_service.dart';

import '../../../builders/monthly_report_builder.dart';
import '../../../services/report_services.dart';
import '../../history/controller/reports_controller.dart';

class MonthlyBillController extends GetxController {
  static MonthlyBillController get instance => Get.find();

  final repository = Get.put(MonthlyBillRepository());

  /// Loading
  final isLoading = false.obs;

  /// PDF Loading
  final isGeneratingPdf = false.obs;

  /// Factory List
  final factories = <FactoryModel>[].obs;

  /// Selected Factory
  final selectedFactory = Rxn<FactoryModel>();

  /// Selected Month
  final selectedMonth = DateTime.now().obs;

  final companies = <CompanyModel>[].obs;

  final selectedCompany = Rxn<CompanyModel>();

  /// Factory Monthly Summary
  final factoryMonthly = FactoryMonthlyModel.empty().obs;

  /// Monthly Records
  final records = <MonthlyBillRecordModel>[].obs;

  /// Final Report
  final report = MonthlyBillReportModel.empty().obs;

  Uint8List? _cachedPdf;

  String? _cachedFactoryId;

  String? _cachedMonthKey;

  String get selectedMonthKey {
    return DateFormat('yyyy-MM').format(selectedMonth.value);
  }

  String get billNumber {
    return BillNumberHelper.generate(selectedMonth.value);
  }

  List<MonthlyBillRecordModel> get previewRecords {
    return records.take(5).toList();
  }

  // Future<void> _reload() async {
  //   _clearPdfCache();

  //   await loadMonthlyData();
  // }

  @override
  void onInit() {
    super.onInit();
    loadCompanies();

    loadFactories();
  }

  Future<Uint8List> _generatePdf() async {
    ///----------------------------------------------------------
    /// No Records
    ///----------------------------------------------------------

    if (records.isEmpty) {
      throw 'No records found for the selected month.';
    }

    ///----------------------------------------------------------
    /// Return Cached PDF
    ///----------------------------------------------------------

    if (_cachedPdf != null &&
        _cachedFactoryId == selectedFactory.value?.id &&
        _cachedMonthKey == selectedMonthKey) {
      return _cachedPdf!;
    }

    isGeneratingPdf.value = true;

    try {
      ///----------------------------------------------------------
      /// Generate PDF
      ///----------------------------------------------------------

      final pdf = await MonthlyBillPdfService.generate(report.value);

      ///----------------------------------------------------------
      /// Cache
      ///----------------------------------------------------------

      _cachedPdf = pdf;
      _cachedFactoryId = selectedFactory.value?.id;
      _cachedMonthKey = selectedMonthKey;

      ///----------------------------------------------------------
      /// Save Report History (Background)
      ///----------------------------------------------------------

      _saveReportHistory();

      return pdf;
    } finally {
      isGeneratingPdf.value = false;
    }
  }

  Future<void> _saveReportHistory() async {
    try {
      await ReportService.saveMonthly(
        report: report.value,

        /// TODO:
        /// Replace with logged in user id
        createdBy: 'system',
      );

      if (Get.isRegistered<ReportsController>()) {
        await Get.find<ReportsController>().loadReports();
      }
    } catch (e, stackTrace) {
      debugPrint('Report History Save Error: $e');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  Future<void> previewPdf() async {
    try {
      /// Generate PDF if it is not already cached
      final pdfBytes = await _generatePdf();

      /// Preview generated PDF
      await PdfPreviewService.preview(pdfBytes);
    } catch (e) {
      Get.snackbar('PDF Error', e.toString());
    }
  }

  Future<void> downloadPdf() async {
    try {
      if (_cachedPdf == null) {
        throw 'Please generate the report first.';
      }

      await PdfDownloadService.saveAndOpen(
        pdfBytes: _cachedPdf!,
        fileName: PdfFileNameHelper.monthly(
          factoryName: report.value.factory.name,
          month: report.value.month,
        ),
      );
    } catch (e) {
      Get.snackbar('Download Failed', e.toString());
    }
  }

  Future<void> sharePdf() async {
    try {
      if (_cachedPdf == null) {
        throw 'Please generate the report first.';
      }

      await PdfShareService.share(
        pdfBytes: _cachedPdf!,
        fileName: PdfFileNameHelper.monthly(
          factoryName: report.value.factory.name,
          month: report.value.month,
        ),
      );
    } catch (e) {
      Get.snackbar('Share Failed', e.toString());
    }
  }

  void _clearPdfCache() {
    _cachedPdf = null;
    _cachedFactoryId = null;
    _cachedMonthKey = null;
  }

  Future<void> loadCompanies() async {
    try {
      isLoading.value = true;

      final result = await CompanyRepository.instance.fetchAllCompanies();

      companies.assignAll(result);

      if (companies.isNotEmpty) {
        selectedCompany.value = companies.first;

        await loadFactories();
      }
    } catch (e, stackTrace) {
      debugPrint('Load Companies Error: $e');
      debugPrintStack(stackTrace: stackTrace);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadFactories() async {
    if (selectedCompany.value == null) return;

    try {
      final result = await FactoryRepository.instance.fetchFactoriesByCompany(
        selectedCompany.value!.id,
      );

      factories.assignAll(result);

      if (factories.isNotEmpty) {
        selectedFactory.value = factories.first;

        await loadMonthlyData();
      } else {
        selectedFactory.value = null;

        records.clear();

        factoryMonthly.value = FactoryMonthlyModel.empty();

        report.value = MonthlyBillReportModel.empty();
      }
    } catch (e) {
      Get.snackbar('Oh Snap!', e.toString());
    }
  }

  ///==========================================================
  /// Load Monthly Data
  ///==========================================================

  Future<void> loadMonthlyData() async {
    if (selectedFactory.value == null) return;

    try {
      isLoading.value = true;

      final results = await Future.wait([
        repository.fetchFactoryMonthly(
          factoryId: selectedFactory.value!.id,
          monthKey: selectedMonthKey,
        ),
        repository.fetchMonthlyRecords(
          factoryId: selectedFactory.value!.id,
          monthKey: selectedMonthKey,
        ),
      ]);

      factoryMonthly.value = results[0] as FactoryMonthlyModel;

      records.assignAll(results[1] as List<MonthlyBillRecordModel>);

      /// Build report data only.
      /// Do NOT generate PDF or save report history here.
      _buildReportModel();
    } catch (e) {
      Get.snackbar('Oh Snap!', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  ///==========================================================
  /// Build Report Model
  ///==========================================================

  void _buildReportModel() {
    report.value = MonthlyReportBuilder.build(
      factory: selectedFactory.value!,
      factoryMonthly: factoryMonthly.value,
      records: records,
      month: selectedMonth.value,
      monthKey: selectedMonthKey,
      billNo: billNumber,
    );
  }

  Future<void> updateSelectedCompany(CompanyModel company) async {
    selectedCompany.value = company;

    factories.clear();

    selectedFactory.value = null;

    _clearPdfCache();

    await loadFactories();
  }

  Future<void> updateSelectedFactory(FactoryModel factory) async {
    selectedFactory.value = factory;

    _clearPdfCache();

    await loadMonthlyData();
  }

  Future<void> updateSelectedMonth(DateTime month) async {
    selectedMonth.value = month;

    _clearPdfCache();

    await loadMonthlyData();
  }

  Future<void> pickMonth(BuildContext context) async {
    final picked = await MonthPickerHelper.pickMonth(
      context: context,
      initialDate: selectedMonth.value,
    );

    if (picked == null) return;

    await updateSelectedMonth(picked);
  }

  Future<void> refresh() async {
    _clearPdfCache();

    await loadMonthlyData();
  }
}
