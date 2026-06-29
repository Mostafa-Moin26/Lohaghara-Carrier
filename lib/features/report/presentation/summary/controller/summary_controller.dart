import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lohaghara_carrier/core/helpers/amount_in_words_helper.dart';
import 'package:lohaghara_carrier/core/helpers/bill_number_helper.dart';
import 'package:lohaghara_carrier/core/helpers/month_picker_helper.dart';
import 'package:lohaghara_carrier/core/helpers/pdf_file_name_helper.dart';
import 'package:lohaghara_carrier/features/company/data/models/company_model.dart';
import 'package:lohaghara_carrier/features/factory/data/models/factory_monthly_model.dart';
import 'package:lohaghara_carrier/features/report/data/models/summary_report_model.dart';
import 'package:lohaghara_carrier/features/report/data/repositories/summary_repository.dart';
import 'package:lohaghara_carrier/features/report/services/pdf/pdf_download_service.dart';
import 'package:lohaghara_carrier/features/report/services/pdf/pdf_preview_service.dart';
import 'package:lohaghara_carrier/features/report/services/pdf/pdf_share_service.dart';
import 'package:lohaghara_carrier/features/report/services/pdf/summary_pdf_service.dart';

class SummaryController extends GetxController {
  static SummaryController get instance => Get.find();

  /// Repository
  final repository = Get.put(SummaryRepository());

  /// Loading
  final isLoading = false.obs;

  /// Generate PDF Loading
  final isGeneratingPdf = false.obs;

  /// Companies
  final companies = <CompanyModel>[].obs;

  /// Selected Company
  final selectedCompany = Rxn<CompanyModel>();

  /// Selected Month
  final selectedMonth = DateTime.now().obs;

  /// Factory Summary
  final summaryFactories = <FactoryMonthlyModel>[].obs;

  /// Generated Report
  final report = SummaryReportModel.empty().obs;

  ///==========================================================
  /// PDF Cache
  ///==========================================================

  Uint8List? _cachedPdf;

  String? _cachedCompanyId;

  String? _cachedMonthKey;

  void _buildReportModel() {
    if (selectedCompany.value == null) return;

    final factories = List<FactoryMonthlyModel>.from(summaryFactories);

    final totalTrips = factories.fold<int>(
      0,
      (sum, item) => sum + item.totalTrips,
    );

    final totalAmount = factories.fold<double>(
      0,
      (sum, item) => sum + item.totalAmount,
    );

    report.value = SummaryReportModel(
      company: selectedCompany.value!,
      monthKey: DateFormat('yyyy-MM').format(selectedMonth.value),
      month: selectedMonth.value,
      billNo: BillNumberHelper.generate(selectedMonth.value),
      factories: factories,
      totalTrips: totalTrips,
      totalAmount: totalAmount,
      amountInWords: AmountInWordsHelper.convert(totalAmount),
    );
  }

  ///==========================================================
  /// Generate PDF (With Cache)
  ///==========================================================

  Future<Uint8List> _generatePdf() async {
    final companyId = selectedCompany.value!.id;
    final monthKey = DateFormat('yyyy-MM').format(selectedMonth.value);

    /// Return Cache
    if (_cachedPdf != null &&
        _cachedCompanyId == companyId &&
        _cachedMonthKey == monthKey) {
      return _cachedPdf!;
    }

    /// Build Report
    _buildReportModel();

    final pdf = await SummaryPdfService.generate(report: report.value);

    /// Save Cache
    _cachedPdf = pdf;
    _cachedCompanyId = companyId;
    _cachedMonthKey = monthKey;

    return pdf;
  }

  ///==========================================================
  /// Clear PDF Cache
  ///==========================================================

  void _clearPdfCache() {
    _cachedPdf = null;
    _cachedCompanyId = null;
    _cachedMonthKey = null;
  }

  @override
  void onInit() {
    super.onInit();

    loadCompanies();
  }

  Future<void> loadCompanies() async {
    try {
      isLoading.value = true;

      final result = await repository.fetchCompanies();

      companies.assignAll(result);

      if (companies.isNotEmpty) {
        selectedCompany.value = companies.first;

        await loadSummary();
      }
    } catch (e) {
      Get.snackbar('Oh Snap!', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadSummary() async {
    if (selectedCompany.value == null) return;

    try {
      isLoading.value = true;

      final monthKey = DateFormat('yyyy-MM').format(selectedMonth.value);

      final result = await repository.fetchFactorySummary(
        companyId: selectedCompany.value!.id,
        monthKey: monthKey,
      );

      summaryFactories.assignAll(result);

      /// NEW
      _buildReportModel();
    } catch (e) {
      Get.snackbar('Oh Snap!', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateSelectedCompany(CompanyModel company) async {
    selectedCompany.value = company;

    _clearPdfCache();

    await loadSummary();
  }

  Future<void> updateSelectedMonth(DateTime month) async {
    selectedMonth.value = month;

    _clearPdfCache();

    await loadSummary();
  }

  Future<void> pickMonth(BuildContext context) async {
    final picked = await MonthPickerHelper.pickMonth(
      context: context,
      initialDate: selectedMonth.value,
    );

    if (picked == null) return;

    await updateSelectedMonth(picked);
  }

  Future<void> refreshSummary() async {
    _clearPdfCache();

    await loadSummary();
  }

  Future<void> previewPdf() async {
    try {
      isGeneratingPdf.value = true;

      final pdfBytes = await _generatePdf();

      await PdfPreviewService.preview(pdfBytes);
    } catch (e) {
      Get.snackbar('PDF Error', e.toString());
    } finally {
      isGeneratingPdf.value = false;
    }
  }

  Future<void> downloadPdf() async {
    try {
      isGeneratingPdf.value = true;

      final pdfBytes = await _generatePdf();

      await PdfDownloadService.saveAndOpen(
        pdfBytes: pdfBytes,
        fileName: pdfFileName,
      );

      Get.snackbar('Success', 'PDF downloaded successfully.');
    } catch (e) {
      Get.snackbar('PDF Error', e.toString());
    } finally {
      isGeneratingPdf.value = false;
    }
  }

  Future<void> sharePdf() async {
    try {
      isGeneratingPdf.value = true;

      final pdfBytes = await _generatePdf();

      await PdfShareService.share(pdfBytes: pdfBytes, fileName: pdfFileName);
    } catch (e) {
      Get.snackbar('PDF Error', e.toString());
    } finally {
      isGeneratingPdf.value = false;
    }
  }

  int get totalFactories => summaryFactories.length;

  int get totalTrips {
    return summaryFactories.fold(0, (sum, factory) => sum + factory.totalTrips);
  }

  double get totalAmount {
    return summaryFactories.fold(
      0.0,
      (sum, factory) => sum + factory.totalAmount,
    );
  }

  String get billNumber {
    return BillNumberHelper.generate(selectedMonth.value);
  }

  String get pdfFileName {
    return PdfFileNameHelper.summary(
      companyName: selectedCompany.value!.name,
      month: selectedMonth.value,
    );
  }
}
