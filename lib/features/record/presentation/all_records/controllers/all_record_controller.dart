import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lohaghara_carrier/core/constants/enums.dart';
import 'package:lohaghara_carrier/features/record/data/models/record_model.dart';
import 'package:lohaghara_carrier/features/record/data/repositories/record_repository.dart';

class AllRecordController extends GetxController {
  static AllRecordController get instance => Get.find();

  //══════════════════════════════════════════════════════
  // Repository
  //══════════════════════════════════════════════════════

  final RecordRepository recordRepository = Get.put(RecordRepository());

  //══════════════════════════════════════════════════════
  // Pagination
  //══════════════════════════════════════════════════════

  static const int pageSize = 10;

  final ScrollController scrollController = ScrollController();

  DocumentSnapshot? lastDocument;

  Query<Map<String, dynamic>>? currentQuery;

  final hasMore = true.obs;

  final isLoading = false.obs;

  final isLoadingMore = false.obs;

  //══════════════════════════════════════════════════════
  // Search
  //══════════════════════════════════════════════════════

  final TextEditingController searchController = TextEditingController();

  final searchQuery = ''.obs;

  Timer? searchDebounce;

  //══════════════════════════════════════════════════════
  // Filters
  //══════════════════════════════════════════════════════

  final selectedFilter = RecordFilterType.all.obs;

  final selectedDate = Rxn<DateTime>();

  final filters = [
    RecordFilterType.all,
    RecordFilterType.today,
    RecordFilterType.thisWeek,
    RecordFilterType.thisMonth,
  ];

  //══════════════════════════════════════════════════════
  // Data
  //══════════════════════════════════════════════════════

  final records = <RecordModel>[].obs;

  final filteredRecords = <RecordModel>[].obs;

  //══════════════════════════════════════════════════════
  // Lifecycle
  //══════════════════════════════════════════════════════

  @override
  void onInit() {
    super.onInit();

    fetchRecords();

    scrollController.addListener(_scrollListener);
  }

  @override
  void onClose() {
    searchController.dispose();

    scrollController.dispose();

    searchDebounce?.cancel();

    super.onClose();
  }

  //══════════════════════════════════════════════════════
  // Pagination
  //══════════════════════════════════════════════════════

  void _scrollListener() {
    if (!scrollController.hasClients) return;

    if (isLoadingMore.value) return;

    if (!hasMore.value) return;

    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      fetchRecords(query: currentQuery, loadMore: true);
    }
  }

  Query<Map<String, dynamic>> _applyDateRange(
    Query<Map<String, dynamic>> query,
    DateTime start,
    DateTime end,
  ) {
    return query
        .where('Date', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('Date', isLessThan: Timestamp.fromDate(end));
  }

  //══════════════════════════════════════════════════════
  // Search & Filter
  //══════════════════════════════════════════════════════

  Query<Map<String, dynamic>> buildQuery() {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection(
      'Records',
    );

    switch (selectedFilter.value) {
      case RecordFilterType.today:
        final now = DateTime.now();

        final start = DateTime(now.year, now.month, now.day);

        query = _applyDateRange(
          query,
          start,
          start.add(const Duration(days: 1)),
        );

        break;

      case RecordFilterType.thisWeek:
        final now = DateTime.now();

        final daysFromSaturday = (now.weekday + 1) % 7;

        final start = DateTime(
          now.year,
          now.month,
          now.day,
        ).subtract(Duration(days: daysFromSaturday));

        query = _applyDateRange(
          query,
          start,
          start.add(const Duration(days: 7)),
        );

        break;

      case RecordFilterType.thisMonth:
        query = query.where(
          'MonthKey',
          isEqualTo: DateFormat('yyyy-MM').format(DateTime.now()),
        );

        break;

      case RecordFilterType.customDate:
        if (selectedDate.value != null) {
          final start = DateTime(
            selectedDate.value!.year,
            selectedDate.value!.month,
            selectedDate.value!.day,
          );

          query = _applyDateRange(
            query,
            start,
            start.add(const Duration(days: 1)),
          );
        }

        break;

      case RecordFilterType.all:
        break;
    }

    if (searchQuery.value.isNotEmpty) {
      query = query.where('SearchTokens', arrayContains: searchQuery.value);
    }

    return query.orderBy('Date', descending: true);
  }

  /// Search
  void onSearchChanged(String value) {
    searchDebounce?.cancel();

    searchDebounce = Timer(const Duration(milliseconds: 500), () async {
      searchQuery.value = value.trim().toLowerCase();

      await fetchRecords(query: buildQuery());
    });
  }

  /// Update Filter
  Future<void> updateFilter(RecordFilterType filter) async {
    selectedFilter.value = filter;

    await fetchRecords(query: buildQuery());
  }

  /// Pick Custom Date
  Future<void> pickCustomDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (pickedDate == null) return;

    selectedDate.value = pickedDate;

    selectedFilter.value = RecordFilterType.customDate;

    await fetchRecords(query: buildQuery());
  }

  /// Clear Custom Date
  Future<void> clearCustomDate() async {
    selectedDate.value = null;

    selectedFilter.value = RecordFilterType.all;

    await fetchRecords(query: buildQuery());
  }

  /// Apply UI Changes
  void applyFilters() {
    filteredRecords.assignAll(records);
  }

  /// Update Search
  void updateSearch(String value) {
    searchQuery.value = value;

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

  //══════════════════════════════════════════════════════
  // Records
  //══════════════════════════════════════════════════════

  /// Fetch Records
  Future<void> fetchRecords({
    Query<Map<String, dynamic>>? query,
    bool loadMore = false,
  }) async {
    try {
      if (loadMore) {
        if (!hasMore.value || isLoadingMore.value) return;

        isLoadingMore.value = true;
      } else {
        isLoading.value = true;

        records.clear();
        filteredRecords.clear();

        lastDocument = null;
        hasMore.value = true;

        currentQuery = query;
      }

      final snapshot = await recordRepository.fetchRecords(
        query: currentQuery,
        lastDocument: loadMore ? lastDocument : null,
        pageSize: pageSize,
      );

      final fetchedRecords = snapshot.docs
          .map(RecordModel.fromSnapshot)
          .toList();

      if (loadMore) {
        records.addAll(fetchedRecords);
      } else {
        records.assignAll(fetchedRecords);
      }

      if (snapshot.docs.isNotEmpty) {
        lastDocument = snapshot.docs.last;
      }

      hasMore.value = snapshot.docs.length == pageSize;

      applyFilters();
    } catch (e) {
      Get.snackbar('Oh Snap!', e.toString());
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  /// Refresh Records
  Future<void> refreshRecords() async {
    await fetchRecords(query: buildQuery());
  }
}
