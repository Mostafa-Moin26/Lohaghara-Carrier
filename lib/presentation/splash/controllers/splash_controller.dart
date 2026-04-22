import 'package:get/get.dart';

import '../../onboarding/onboarding.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    navigateToNext();
  }

  void navigateToNext() async {
    await Future.delayed(const Duration(seconds: 10));

    Get.offAll(() => const OnboardingScreen());
  }
}
