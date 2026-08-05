import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/enums.dart';
import '../../../data/models/report_model.dart';
import '../../../data/repositories/report_repository.dart';

class ReportsController extends GetxController {
  static ReportsController get instance => Get.find();

  final ReportRepository _repository = Get.find();

  ///==========================================================
  /// Loading
  ///==========================================================

  final isLoading = false.obs;

  ///==========================================================
  /// Search
  ///==========================================================

  final searchQuery = ''.obs;

  ///==========================================================
  /// Filter
  ///==========================================================

  final selectedFilter = ReportFilterType.all.obs;

  final filters = ReportFilterType.values;

  ///==========================================================
  /// Reports
  ///==========================================================

  final allReports = <ReportModel>[].obs;

  final reports = <ReportModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    loadReports();
  }

  //==========================================================
  // Load Reports
  //==========================================================

  Future<void> loadReports() async {
    try {
      isLoading.value = true;

      final result = await _repository.fetchReports();

      allReports.assignAll(result);

      _applyFilters();
    } catch (e, stackTrace) {
      debugPrint('Load Reports Error: $e');
      debugPrintStack(stackTrace: stackTrace);
    } finally {
      isLoading.value = false;
    }
  }

  //==========================================================
  // Refresh
  //==========================================================

  Future<void> refresh() async {
    await loadReports();
  }

  //==========================================================
  // Update Filter
  //==========================================================

  void updateFilter(ReportFilterType value) {
    selectedFilter.value = value;

    _applyFilters();
  }

  //==========================================================
  // Search
  //==========================================================

  void updateSearch(String value) {
    searchQuery.value = value;

    _applyFilters();
  }

  //==========================================================
  // Apply Search + Filter
  //==========================================================

  void _applyFilters() {
    List<ReportModel> filtered = List.from(allReports);

    //--------------------------------------------------------
    // Filter
    //--------------------------------------------------------

    switch (selectedFilter.value) {
      case ReportFilterType.all:
        break;

      case ReportFilterType.monthly:
        filtered = filtered.where((e) => e.reportType == 'monthly').toList();
        break;

      case ReportFilterType.summary:
        filtered = filtered.where((e) => e.reportType == 'summary').toList();
        break;

      case ReportFilterType.thisMonth:
        final now = DateTime.now();

        filtered = filtered.where((e) {
          return e.month.year == now.year && e.month.month == now.month;
        }).toList();
        break;

      case ReportFilterType.lastThreeMonths:
        final now = DateTime.now();

        filtered = filtered.where((e) {
          final reportDate = e.month;

          final difference =
              (now.year - reportDate.year) * 12 +
              (now.month - reportDate.month);

          return difference >= 0 && difference < 3;
        }).toList();

        break;
    }

    //--------------------------------------------------------
    // Search
    //--------------------------------------------------------

    final keyword = searchQuery.value.trim().toLowerCase();

    if (keyword.isNotEmpty) {
      filtered = filtered.where((report) {
        return report.companyName.toLowerCase().contains(keyword) ||
            (report.factoryName ?? '').toLowerCase().contains(keyword) ||
            report.billNo.toLowerCase().contains(keyword);
      }).toList();
    }

    reports.assignAll(filtered);
  }

  //==========================================================
  // Delete Report
  //==========================================================

  Future<void> deleteReport(String reportId) async {
    try {
      isLoading.value = true;

      await _repository.deleteReport(reportId);

      await refresh();

      Get.snackbar('Success', 'Report deleted successfully.');
    } catch (e) {
      Get.snackbar('Oh Snap!', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
