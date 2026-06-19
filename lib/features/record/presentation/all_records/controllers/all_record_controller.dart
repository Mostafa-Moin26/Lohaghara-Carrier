import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/constants/enums.dart';
import 'package:lohaghara_carrier/features/record/data/models/record_model.dart';
import 'package:lohaghara_carrier/features/record/data/repositories/record_repository.dart';

class AllRecordController extends GetxController {
  static AllRecordController get instance => Get.find();

  /// Repository
  final recordRepository = Get.put(RecordRepository());

  /// Loading
  final isLoading = false.obs;

  /// Search
  final searchQuery = ''.obs;

  /// Filters
  final selectedFilter = RecordFilterType.all.obs;
  final filters = RecordFilterType.values;

  /// Records
  final records = <RecordModel>[].obs;
  final filteredRecords = <RecordModel>[].obs;

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

  /// Apply Search + Filter
  void applyFilters() {
    List<RecordModel> result = List.from(records);

    /// Search
    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value.toLowerCase();

      result = result.where((record) {
        return record.companyName.toLowerCase().contains(query) ||
            record.factoryName.toLowerCase().contains(query) ||
            record.truckNumber.toLowerCase().contains(query) ||
            record.item.toLowerCase().contains(query);
      }).toList();
    }

    /// Filter
    final now = DateTime.now();

    switch (selectedFilter.value) {
      case RecordFilterType.today:
        result = result.where((record) {
          return record.date.year == now.year &&
              record.date.month == now.month &&
              record.date.day == now.day;
        }).toList();
        break;

      case RecordFilterType.thisWeek:
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));

        result = result.where((record) {
          return record.date.isAfter(
                startOfWeek.subtract(const Duration(days: 1)),
              ) &&
              record.date.isBefore(now.add(const Duration(days: 1)));
        }).toList();
        break;

      case RecordFilterType.thisMonth:
        result = result.where((record) {
          return record.date.year == now.year && record.date.month == now.month;
        }).toList();
        break;

      case RecordFilterType.customDate:
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
