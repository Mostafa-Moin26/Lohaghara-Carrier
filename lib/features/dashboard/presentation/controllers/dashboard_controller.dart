import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  Rx<DateTime> selectedMonth = DateTime.now().obs;

  void updateSelectedMonth(DateTime newMonth) {
    selectedMonth.value = newMonth;
    fetchMonthlyDashboardData();
  }

  void fetchMonthlyDashboardData() {
    if (kDebugMode) {
      print(
        "Fetching dashboard data for: "
        "${selectedMonth.value.month}/${selectedMonth.value.year}",
      );
    }
  }
}
