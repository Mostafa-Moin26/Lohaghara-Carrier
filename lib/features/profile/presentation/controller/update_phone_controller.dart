import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/constants/image_strings.dart';
import 'package:lohaghara_carrier/core/helpers/network_manager.dart';
import 'package:lohaghara_carrier/core/popups/full_screen_loader.dart';
import 'package:lohaghara_carrier/core/popups/loaders.dart';
import 'package:lohaghara_carrier/features/profile/data/repositories/user_repositories.dart';
import 'package:lohaghara_carrier/features/profile/presentation/controller/user_controller.dart';

/// Controller to manage user-related functionality.
class UpdatePhoneController extends GetxController {
  static UpdatePhoneController get instance => Get.find();

  final phone = TextEditingController();

  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());

  GlobalKey<FormState> updatePhoneFormKey = GlobalKey<FormState>();

  /// Init user data when Home Screen appears
  @override
  void onInit() {
    initializePhone();

    super.onInit();
  }

  /// Fetch user record
  Future<void> initializePhone() async {
    phone.text = userController.user.value.phoneNumber;
  }

  /// Update user phone number
  Future<void> updateUserPhone() async {
    try {
      /// Start Loading
      FullScreenLoader.openLoadingDialog(
        'We are updating your information...',
        AppImageStrings.docerAnimation,
      );

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoader.stopLoading();

        return;
      }

      /// Form Validation
      if (!updatePhoneFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();

        return;
      }

      /// Update user's phone number in Firestore
      Map<String, dynamic> phoneData = {'PhoneNumber': phone.text.trim()};

      await userRepository.updateSingleField(phoneData);

      /// Update Rx User Value
      userController.user.value.phoneNumber = phone.text.trim();

      userController.user.refresh();

      /// Remove Loader
      FullScreenLoader.stopLoading();

      /// Move to previous screen
      Get.back();

      /// Show Success Message
      AppLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your phone number has been updated.',
      );
    } catch (e) {
      /// Remove Loader
      FullScreenLoader.stopLoading();

      /// Show Error To User
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
