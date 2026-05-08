import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/constants/enums.dart';

class AllRecordController extends GetxController {
  final searchQuery = ''.obs;

  final selectedFilter = RecordFilterType.all.obs;
  final filters = RecordFilterType.values;

  /// Update filters
  void updateFilter(RecordFilterType value) {
    selectedFilter.value = value;
  }

  /// Search
  void updateSearch(String value) {
    searchQuery.value = value;
  }
}
