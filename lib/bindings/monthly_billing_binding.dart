import 'package:get/get.dart';
import 'package:lohaghara_carrier/features/company/data/repositories/company_repository.dart';
import 'package:lohaghara_carrier/features/factory/data/repositories/factory_repository.dart';
import 'package:lohaghara_carrier/features/report/data/repositories/monthly_bill_repository.dart';
import 'package:lohaghara_carrier/features/report/presentation/summary/controller/monthly_bill_controller.dart';

class MonthlyBillBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CompanyRepository());

    Get.lazyPut(() => FactoryRepository());

    Get.lazyPut(() => MonthlyBillRepository());

    Get.lazyPut(() => MonthlyBillController());
  }
}
