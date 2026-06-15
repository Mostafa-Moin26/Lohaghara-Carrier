import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lohaghara_carrier/features/auth/data/repositories/authentication_repository.dart';

class SplashController extends GetxController {
  final authRepo = Get.find<AuthenticationRepository>();

  /// Variables
  final deviceStorage = GetStorage();

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      authRepo.screenRedirect();
    });
  }
}
