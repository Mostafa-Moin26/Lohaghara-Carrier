import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lohaghara_carrier/core/helpers/bill_number_helper.dart';
import 'package:lohaghara_carrier/core/helpers/month_picker_helper.dart';
import 'package:lohaghara_carrier/features/company/data/models/company_model.dart';
import 'package:lohaghara_carrier/features/factory/data/models/factory_monthly_model.dart';
import 'package:lohaghara_carrier/features/report/data/repositories/summary_repository.dart';

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
    } catch (e) {
      Get.snackbar('Oh Snap!', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateSelectedCompany(CompanyModel company) async {
    selectedCompany.value = company;

    await loadSummary();
  }

  Future<void> updateSelectedMonth(DateTime month) async {
    selectedMonth.value = month;

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
    await loadSummary();
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
}
