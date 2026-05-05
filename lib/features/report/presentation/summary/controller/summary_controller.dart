import 'package:get/get.dart';

enum ReportType { monthly, summary }

class SummaryController extends GetxController {
  final selectedType = ReportType.summary.obs;

  final selectedCompany = "Meghna Executive Holding".obs;

  final fromMonth = DateTime(2026, 1).obs;
  final toMonth = DateTime(2026, 3).obs;

  void changeType(ReportType type) {
    selectedType.value = type;
  }

  void generateReport() {
    // later: API call
  }
}
