import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/constants/image_strings.dart';
import 'package:lohaghara_carrier/core/helpers/network_manager.dart';
import 'package:lohaghara_carrier/core/popups/full_screen_loader.dart';
import 'package:lohaghara_carrier/core/popups/loaders.dart';
import 'package:lohaghara_carrier/features/auth/data/repositories/authentication_repository.dart';
import 'package:lohaghara_carrier/features/auth/presentation/password/reset/reset_password_screen.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  /// Variables
  final email = TextEditingController();

  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  /// Send Reset Password Email
  Future<void> sendPasswordResetEmail() async {
    try {
      /// Start Loading
      FullScreenLoader.openLoadingDialog(
        'Processing your request...',
        AppImageStrings.docerAnimation,
      );

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoader.stopLoading();

        return;
      }

      /// Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();

        return;
      }

      /// Send Email to Reset Password
      await AuthenticationRepository.instance.sendPasswordResetEmail(
        email.text.trim(),
      );

      /// Remove Loader
      FullScreenLoader.stopLoading();

      /// Show Success Screen
      AppLoaders.successSnackBar(
        title: 'Email Sent',
        message: 'Email link sent to reset your password.',
      );

      /// Redirect'
      Get.to(() => ResetPassword(email: email.text.trim()));
    } catch (e) {
      /// Remove Loader
      FullScreenLoader.stopLoading();

      /// Show Error To User
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// Resend Password Reset Email
  Future<void> resendPasswordResetEmail(String email) async {
    try {
      /// Start Loading
      FullScreenLoader.openLoadingDialog(
        'Processing your request...',
        AppImageStrings.docerAnimation,
      );

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoader.stopLoading();

        return;
      }

      /// Send Email to Reset Password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      /// Remove Loader
      FullScreenLoader.stopLoading();

      /// Show Success Screen
      AppLoaders.successSnackBar(
        title: 'Email Sent',
        message: 'Email link sent to reset your password.',
      );
    } catch (e) {
      /// Remove Loader
      FullScreenLoader.stopLoading();

      /// Show Error To User
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
