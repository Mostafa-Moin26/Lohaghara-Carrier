import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';

class ConfirmationDialog {
  ConfirmationDialog._();

  static Future<void> show({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    String confirmText = 'Delete',
    String cancelText = 'Cancel',
    Color confirmColor = Colors.red,
  }) async {
    await Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
        ),
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(onPressed: Get.back, child: Text(cancelText)),

          ElevatedButton(
            onPressed: () {
              Get.back();

              onConfirm();
            },
            style: ElevatedButton.styleFrom(backgroundColor: confirmColor),
            child: Text(
              confirmText,
              style: const TextStyle(color: AppColors.white),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
