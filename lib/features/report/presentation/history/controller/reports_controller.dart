import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/constants/enums.dart';

class ReportsController extends GetxController {
  final searchQuery = ''.obs;

  /// Selected Filter
  final selectedFilter = ReportFilterType.all.obs;

  /// Filters List
  final filters = ReportFilterType.values;

  /// Reports
  final reports = <Map<String, dynamic>>[
    {
      "type": "Monthly Report",
      "title": "Meghna Knit Composite Ltd.",
      "date": "Mar 2026",
      "billNo": "Lohagara 16",
      "amount": "10,05,900",
      "trucks": "55",
      "time": "Today",
    },
    {
      "type": "Summary Report",
      "title": "Meghna Executive Holding",
      "date": "Jan 2026 - Mar 2026",
      "billNo": "Lohagara 16",
      "amount": "23,19,300",
      "trucks": "131",
      "time": "2 days ago",
    },
  ].obs;

  /// Update Filter
  void updateFilter(ReportFilterType value) {
    selectedFilter.value = value;
  }

  /// Search
  void updateSearch(String value) {
    searchQuery.value = value;
  }
}
