import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    navigateToNext();
  }

  void navigateToNext() async {
    await Future.delayed(const Duration(seconds: 10000));

    // Get.offAll(() => const OnboardingScreen());
  }
}
