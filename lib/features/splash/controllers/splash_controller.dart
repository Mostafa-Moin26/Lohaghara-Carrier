import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lohaghara_carrier/features/auth/data/repositories/authentication_repository.dart';
import 'package:lohaghara_carrier/routes/app_routes.dart';

class SplashController extends GetxController {
  final authRepo = Get.find<AuthenticationRepository>();

  /// Variables
  final deviceStorage = GetStorage();

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      screenRedirect();
    });
  }

  Future<void> screenRedirect() async {
    await Future.delayed(const Duration(seconds: 2));

    deviceStorage.writeIfNull('IsFirstTime', true);
    deviceStorage.read('IsFirstTime') != true
        ? Get.offAllNamed(AppRoutes.login)
        : Get.offAllNamed(AppRoutes.onboarding);
  }
}
