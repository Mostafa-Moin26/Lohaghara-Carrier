import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lohaghara_carrier/core/constants/image_strings.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/helpers/network_manager.dart';
import 'package:lohaghara_carrier/core/popups/full_screen_loader.dart';
import 'package:lohaghara_carrier/core/popups/loaders.dart';
import 'package:lohaghara_carrier/features/auth/data/repositories/authentication_repository.dart';
import 'package:lohaghara_carrier/features/profile/data/models/user_model.dart';
import 'package:lohaghara_carrier/features/profile/data/repositories/user_repositories.dart';
import 'package:lohaghara_carrier/features/profile/presentation/widgets/re_auth_user_login_form.dart';
import 'package:lohaghara_carrier/routes/app_routes.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = true.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  /// Fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  /// Save user record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      /// First update Rx User and then check if user data is already store. If not store new data
      await fetchUserRecord();

      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          /// Convert Name to First and Last Name
          final nameParts = UserModel.nameParts(
            userCredentials.user!.displayName ?? '',
          );

          final username = UserModel.generateUsername(
            userCredentials.user!.displayName ?? '',
          );

          /// Map Data
          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts.isNotEmpty ? nameParts[0] : '',
            lastName: nameParts.length > 1
                ? nameParts.sublist(1).join(' ')
                : '',
            username: username,
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );

          /// Save User Data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      AppLoaders.warningSnackBar(
        title: 'Data not saved',
        message:
            'Something went wrong while saving your information. '
            'You can re-save your data in your Profile.',
      );
    }
  }

  /// Delete Account Warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(AppSizes.md),
      title: 'Delete Account',
      middleText:
          'Are you sure you want to delete your account permanently? '
          'This action is not reversible and all of your data will be removed permanently.',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
      ),
    );
  }

  /// Delete User Account
  void deleteUserAccount() async {
    try {
      FullScreenLoader.openLoadingDialog(
        'Processing',
        AppImageStrings.docerAnimation,
      );

      /// First re-authenticate user
      final auth = AuthenticationRepository.instance;

      final provider = auth.authUser!.providerData
          .map((e) => e.providerId)
          .first;

      if (provider.isNotEmpty) {
        /// Re Verify Auth Email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();

          await auth.deleteAccount();

          FullScreenLoader.stopLoading();

          Get.offAllNamed(AppRoutes.login);
        } else if (provider == 'password') {
          FullScreenLoader.stopLoading();

          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      FullScreenLoader.stopLoading();

      AppLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// -- RE-AUTHENTICATE before deleting
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      FullScreenLoader.openLoadingDialog(
        'Processing',
        AppImageStrings.docerAnimation,
      );

      /// Check Internet
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoader.stopLoading();

        return;
      }

      /// Form Validation
      if (!reAuthFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();

        return;
      }

      /// Re-Authenticate User
      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
            verifyEmail.text.trim(),
            verifyPassword.text.trim(),
          );

      /// Delete Account
      await AuthenticationRepository.instance.deleteAccount();

      /// Remove Loader
      FullScreenLoader.stopLoading();

      /// Redirect
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      FullScreenLoader.stopLoading();

      AppLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// Upload Profile Image
  Future<void> uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );

      if (image != null) {
        imageUploading.value = true;

        /// Upload Image
        final imageUrl = await userRepository.uploadImage(
          'Users/Images/Profile/',
          image,
        );

        /// Update User Image Record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};

        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;

        AppLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Profile Image has been updated!',
        );
      }
    } catch (e) {
      AppLoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: 'Something went wrong: $e',
      );
    } finally {
      imageUploading.value = false;
    }
  }
}
