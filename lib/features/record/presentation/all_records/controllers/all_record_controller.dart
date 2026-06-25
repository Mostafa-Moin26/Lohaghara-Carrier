import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/constants/enums.dart';
import 'package:lohaghara_carrier/features/record/data/models/record_model.dart';
import 'package:lohaghara_carrier/features/record/data/repositories/record_repository.dart';

class AllRecordController extends GetxController {
  static AllRecordController get instance => Get.find();

  /// Search
  final searchQuery = ''.obs;
  final searchController = TextEditingController();

  /// Selected Date
  final selectedDate = Rxn<DateTime>();

  /// All Records
  final records = <RecordModel>[].obs;

  /// Repository
  final recordRepository = Get.put(RecordRepository());

  /// Loading
  final isLoading = false.obs;

  /// Filters
  final selectedFilter = RecordFilterType.all.obs;
  final filters = [
    RecordFilterType.all,
    RecordFilterType.today,
    RecordFilterType.thisWeek,
    RecordFilterType.thisMonth,
  ];

  /// Filtered Records
  final filteredRecords = <RecordModel>[].obs;

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool _matchesSearch(RecordModel record, String query) {
    final q = query.trim().toLowerCase();

    return record.companyName.toLowerCase().contains(q) ||
        record.factoryName.toLowerCase().contains(q) ||
        record.truckNumber.toLowerCase().contains(q) ||
        record.unloadPoint.toLowerCase().contains(q) ||
        record.item.toLowerCase().contains(q) ||
        record.remarks.toLowerCase().contains(q);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    fetchRecords();
  }

  /// Fetch Records
  Future<void> fetchRecords() async {
    try {
      isLoading.value = true;

      final fetchedRecords = await recordRepository.fetchAllRecords();

      records.assignAll(fetchedRecords);

      applyFilters();
    } catch (e) {
      Get.snackbar('Oh Snap!', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Update Search
  void updateSearch(String value) {
    searchQuery.value = value;

    applyFilters();
  }

  /// Update Filter
  void updateFilter(RecordFilterType value) {
    selectedFilter.value = value;

    applyFilters();
  }

  Future<void> selectCustomDate(DateTime date) async {
    selectedDate.value = date;

    selectedFilter.value = RecordFilterType.customDate;

    applyFilters();
  }

  void clearDateFilter() {
    selectedDate.value = null;

    selectedFilter.value = RecordFilterType.all;

    applyFilters();
  }

  Future<void> pickCustomDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    searchQuery.value = '';

    if (pickedDate == null) return;

    selectedDate.value = pickedDate;

    selectedFilter.value = RecordFilterType.customDate;

    applyFilters();
  }

  void clearCustomDate() {
    selectedDate.value = null;

    selectedFilter.value = RecordFilterType.all;

    applyFilters();
  }

  /// Apply Search + Filter
  void applyFilters() {
    List<RecordModel> result = List.from(records);

    /// ---------------- Search ---------------- ///
    final query = searchQuery.value.trim().toLowerCase();

    if (query.isNotEmpty) {
      result = result.where((record) {
        return record.companyName.toLowerCase().contains(query) ||
            record.factoryName.toLowerCase().contains(query) ||
            record.truckNumber.toLowerCase().contains(query) ||
            record.item.toLowerCase().contains(query) ||
            record.unloadPoint.toLowerCase().contains(query) ||
            record.remarks.toLowerCase().contains(query);
      }).toList();
    }

    /// ---------------- Date Filter ---------------- ///
    final now = DateTime.now();

    switch (selectedFilter.value) {
      case RecordFilterType.today:
        result = result.where((record) {
          return _isSameDate(record.date, now);
        }).toList();
        break;

      case RecordFilterType.thisWeek:
        final startOfWeek = DateTime(
          now.year,
          now.month,
          now.day,
        ).subtract(Duration(days: now.weekday - 1));

        final endOfWeek = startOfWeek.add(const Duration(days: 7));

        result = result.where((record) {
          return !record.date.isBefore(startOfWeek) &&
              record.date.isBefore(endOfWeek);
        }).toList();
        break;

      case RecordFilterType.thisMonth:
        result = result.where((record) {
          return record.date.year == now.year && record.date.month == now.month;
        }).toList();
        break;

      case RecordFilterType.customDate:
        if (selectedDate.value != null) {
          result = result.where((record) {
            return _isSameDate(record.date, selectedDate.value!);
          }).toList();
        }
        break;

      case RecordFilterType.all:
        break;
    }

    filteredRecords.assignAll(result);
  }

  /// Refresh Records
  Future<void> refreshRecords() async {
    await fetchRecords();
  }
}
