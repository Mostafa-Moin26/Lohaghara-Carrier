import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final isDarkMode = false.obs;
  final notificationsEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();

    /// Detect current theme
    isDarkMode.value = Get.isDarkMode;
  }

  /// Toggle Theme
  void toggleDarkMode(bool value) {
    isDarkMode.value = value;

    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  /// Notifications
  void toggleNotifications(bool value) {
    notificationsEnabled.value = value;
  }
}
