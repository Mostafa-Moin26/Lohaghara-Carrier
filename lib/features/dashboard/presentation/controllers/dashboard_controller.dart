import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lohaghara_carrier/features/dashboard/data/models/dashboard_monthly_model.dart';
import 'package:lohaghara_carrier/features/dashboard/data/repositories/dashboard_repository.dart';
import 'package:lohaghara_carrier/features/record/data/models/record_model.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  //══════════════════════════════════════════════════════
  // Repository
  //══════════════════════════════════════════════════════

  final DashboardRepository repository = Get.put(DashboardRepository());

  //══════════════════════════════════════════════════════
  // State
  //══════════════════════════════════════════════════════

  final selectedMonth = DateTime.now().obs;

  final dashboard = DashboardMonthlyModel.empty().obs;

  final recentRecords = <RecordModel>[].obs;

  final isLoading = false.obs;

  //══════════════════════════════════════════════════════
  // Lifecycle
  //══════════════════════════════════════════════════════

  @override
  void onInit() {
    super.onInit();

    fetchDashboard();
  }

  Future<void> fetchDashboard() async {
    try {
      isLoading.value = true;

      final monthKey = DateFormat('yyyy-MM').format(selectedMonth.value);

      dashboard.value = await repository.fetchDashboardMonthly(monthKey);

      recentRecords.assignAll(await repository.fetchRecentRecords());
    } catch (e) {
      Get.snackbar('Oh Snap!', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateSelectedMonth(DateTime month) async {
    selectedMonth.value = month;

    await fetchDashboard();
  }

  Future<void> refreshDashboard() async {
    await fetchDashboard();
  }
}
