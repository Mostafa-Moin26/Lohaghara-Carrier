import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/constants/image_strings.dart';
import 'package:lohaghara_carrier/core/helpers/network_manager.dart';
import 'package:lohaghara_carrier/core/popups/full_screen_loader.dart';
import 'package:lohaghara_carrier/core/popups/loaders.dart';
import 'package:lohaghara_carrier/features/profile/data/repositories/user_repositories.dart';
import 'package:lohaghara_carrier/features/profile/presentation/controller/user_controller.dart';

/// Controller to manage user-related functionality.
class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();

  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());

  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  /// Init user data when Home Screen appears
  @override
  void onInit() {
    initializeNames();

    super.onInit();
  }

  /// Fetch user record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;

    lastName.text = userController.user.value.lastName;
  }

  /// Update user name
  Future<void> updateUserName() async {
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
      if (!updateUserNameFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();

        return;
      }

      /// Update user's first & last name in Firestore
      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim(),
      };

      await userRepository.updateSingleField(name);

      /// Update Rx User Value
      userController.user.value.firstName = firstName.text.trim();

      userController.user.value.lastName = lastName.text.trim();

      userController.user.refresh();

      /// Remove Loader
      FullScreenLoader.stopLoading();

      /// Move to previous screen
      Get.back();

      /// Show Success Message
      AppLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your name has been updated.',
      );
    } catch (e) {
      /// Remove Loader
      FullScreenLoader.stopLoading();

      /// Show Error To User
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
