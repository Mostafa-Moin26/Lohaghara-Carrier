import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/constants/image_strings.dart';
import 'package:lohaghara_carrier/core/helpers/network_manager.dart';
import 'package:lohaghara_carrier/core/popups/full_screen_loader.dart';
import 'package:lohaghara_carrier/core/popups/loaders.dart';
import 'package:lohaghara_carrier/features/auth/data/models/user_model.dart';
import 'package:lohaghara_carrier/features/auth/data/repositories/authentication_repository.dart';
import 'package:lohaghara_carrier/features/auth/data/repositories/user_repository.dart';
import 'package:lohaghara_carrier/features/auth/presentation/signup/verify_email_screen.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController(); // controller for email input
  final firstName = TextEditingController(); // controller for first name input
  final lastName = TextEditingController(); // controller for last name input
  final username = TextEditingController(); // controller for username input
  final password = TextEditingController(); // controller for password input
  final phoneNumber =
      TextEditingController(); // controller for phone number input

  GlobalKey<FormState> signupFormKey =
      GlobalKey<FormState>(); // form key for form validation

  /// --SIGNUP
  Future<void> signup() async {
    try {
      // Start loading
      FullScreenLoader.openLoadingDialog(
        'We are processing your information...',
        AppImageStrings.docerAnimation,
      );
      // Check Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        // Remove loader
        FullScreenLoader.stopLoading();

        return;
      }
      // Form validation
      if (!signupFormKey.currentState!.validate()) {
        // Remove loader
        FullScreenLoader.stopLoading();

        return;
      }

      // Privacy policy check
      if (!privacyPolicy.value) {
        AppLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message:
              'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use',
        );
        return;
      }
      // Register user in the Firebase Authentication & save user data in the Firestore
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
            email.text.trim(),
            password.text.trim(),
          );

      // Save Authenticated user data in the Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Remove loader
      FullScreenLoader.stopLoading();

      // Show successs message
      AppLoaders.successSnackBar(
        title: 'Congratulations!',
        message: 'Your account has been created! verify email to continue.',
      );

      // Move to verify email screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      // Remove loader
      FullScreenLoader.stopLoading();

      // show some generic error to the user
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
