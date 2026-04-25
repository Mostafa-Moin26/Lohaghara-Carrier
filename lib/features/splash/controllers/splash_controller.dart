import 'package:get/get.dart';
import 'package:lohaghara_carrier/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    navigateToNext();
  }

  void navigateToNext() async {
    await Future.delayed(const Duration(seconds: 5));

    Get.offNamed(AppRoutes.onboarding);
  }
}
