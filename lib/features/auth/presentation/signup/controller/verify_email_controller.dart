import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/common/widgets/success_screen/success_screen.dart';
import 'package:lohaghara_carrier/core/constants/image_strings.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/core/popups/loaders.dart';
import 'package:lohaghara_carrier/features/auth/data/repositories/authentication_repository.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  final authRepo = Get.find<AuthenticationRepository>();

  /// Send Email Whenever Verify Screen appears & Set Timer for auto redirect.
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  /// Send Email Verification link
  Future<void> sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();

      AppLoaders.successSnackBar(
        title: 'Email Sent',
        message: 'Please check your inbox and verify your email.',
      );
    } catch (e) {
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// Timer to automatically redirect on Email Verification
  void setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();

      final user = FirebaseAuth.instance.currentUser;

      if (user?.emailVerified ?? false) {
        timer.cancel();

        Get.off(
          () => SuccessScreen(
            image: AppImageStrings.successfullyRegisterAnimation,
            title: AppTextStrings.yourAccountCreatedTitle,
            subTitle: AppTextStrings.yourAccountCreatedSubTitle,
            onPressed: () => authRepo.screenRedirect(),
          ),
        );
      }
    });
  }

  /// Manually Check if Email is Verified
  Future<void> checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null && currentUser.emailVerified) {
      Get.off(
        () => SuccessScreen(
          image: AppImageStrings.successfullyRegisterAnimation,
          title: AppTextStrings.yourAccountCreatedTitle,
          subTitle: AppTextStrings.yourAccountCreatedSubTitle,
          onPressed: () => authRepo.screenRedirect,
        ),
      );
    }
  }
}
