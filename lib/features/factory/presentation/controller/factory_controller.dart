import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lohaghara_carrier/core/helpers/month_picker_helper.dart';
import 'package:lohaghara_carrier/features/factory/data/models/factory_monthly_model.dart';
import 'package:lohaghara_carrier/features/factory/data/repositories/factory_repository.dart';

class FactoryController extends GetxController {
  static FactoryController get instance => Get.find();

  /// Repository
  final repository = Get.put(FactoryRepository());

  /// Loading
  final isLoading = false.obs;

  /// Search
  final searchController = TextEditingController();
  final searchQuery = ''.obs;

  /// Selected Month
  final selectedMonth = DateTime.now().obs;

  /// Firestore Query
  Query<Map<String, dynamic>>? currentQuery;

  /// Data
  final factories = <FactoryMonthlyModel>[].obs;
  final filteredFactories = <FactoryMonthlyModel>[].obs;

  /// Search Debounce
  Timer? searchDebounce;

  @override
  void onInit() {
    super.onInit();

    fetchFactories();
  }

  @override
  void onClose() {
    searchController.dispose();
    searchDebounce?.cancel();

    super.onClose();
  }

  Future<void> pickMonth(BuildContext context) async {
    final picked = await MonthPickerHelper.pickMonth(
      context: context,
      initialDate: selectedMonth.value,
    );
    if (picked == null) return;

    await updateSelectedMonth(picked);
  }

  /// -------- Firestore Query -------- ///
  Query<Map<String, dynamic>> buildQuery() {
    final monthKey = DateFormat('yyyy-MM').format(selectedMonth.value);

    return FirebaseFirestore.instance
        .collection('FactoryMonthly')
        .where('MonthKey', isEqualTo: monthKey)
        .orderBy('TotalAmount', descending: true);
  }

  /// Fetch Factories
  Future<void> fetchFactories() async {
    try {
      isLoading.value = true;

      currentQuery = buildQuery();

      final snapshot = await repository.fetchFactoryMonthly(
        query: currentQuery!,
      );

      final fetchedFactories = snapshot.docs
          .map((doc) => FactoryMonthlyModel.fromSnapshot(doc))
          .toList();

      factories.assignAll(fetchedFactories);

      applyFilters();
    } catch (e) {
      Get.snackbar('Oh Snap!', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Apply Search Filter
  void applyFilters() {
    List<FactoryMonthlyModel> result = List.from(factories);

    final query = searchQuery.value.trim().toLowerCase();

    if (query.isNotEmpty) {
      result = result.where((factory) {
        return factory.factoryName.toLowerCase().contains(query) ||
            factory.companyName.toLowerCase().contains(query);
      }).toList();
    }

    filteredFactories.assignAll(result);
  }

  /// Search
  void onSearchChanged(String value) {
    searchDebounce?.cancel();

    searchDebounce = Timer(const Duration(milliseconds: 400), () {
      searchQuery.value = value;

      applyFilters();
    });
  }

  /// Update Selected Month
  Future<void> updateSelectedMonth(DateTime month) async {
    selectedMonth.value = month;

    await fetchFactories();
  }

  /// Refresh Factories
  Future<void> refreshFactories() async {
    await fetchFactories();
  }
}
