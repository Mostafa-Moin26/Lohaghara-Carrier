import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lohaghara_carrier/core/constants/image_strings.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/helpers/network_manager.dart';
import 'package:lohaghara_carrier/core/popups/full_screen_loader.dart';
import 'package:lohaghara_carrier/core/popups/loaders.dart';

import 'package:lohaghara_carrier/features/record/data/models/record_model.dart';
import 'package:lohaghara_carrier/features/record/data/repositories/record_repository.dart';
import 'package:lohaghara_carrier/features/record/presentation/all_records/controllers/all_record_controller.dart';

class RecordDetailController extends GetxController {
  static RecordDetailController get instance => Get.find();

  /// Repository
  final recordRepository = RecordRepository.instance;

  /// Loading
  final isDeleting = false.obs;

  /// Current Record
  final Rx<RecordModel> record = RecordModel.empty().obs;

  @override
  void onInit() {
    super.onInit();

    record.value = Get.arguments as RecordModel;
  }

  /// Delete Record Warning Popup
  void deleteRecordWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(AppSizes.md),
      title: 'Delete Record',
      middleText:
          'Are you sure you want to delete this record permanently? '
          'This action cannot be undone.',
      confirm: ElevatedButton(
        onPressed: deleteRecord,
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
        onPressed: () => Get.back(),
        child: const Text('Cancel'),
      ),
    );
  }

  /// Delete Record
  Future<void> deleteRecord() async {
    if (isDeleting.value) return;

    try {
      isDeleting.value = true;

      /// Close confirmation dialog first
      Get.back();

      /// Show Loader
      FullScreenLoader.openLoadingDialog(
        'Deleting Record...',
        AppImageStrings.docerAnimation,
      );

      /// Check Internet
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      /// Delete Record
      await recordRepository.deleteRecord(record.value.id);

      if (Get.isRegistered<AllRecordController>()) {
        final controller = AllRecordController.instance;

        controller.records.removeWhere((item) => item.id == record.value.id);

        controller.applyFilters();
      }

      /// Stop Loader
      FullScreenLoader.stopLoading();

      /// Close Record Details Screen
      Get.back();

      /// Success Message
      AppLoaders.successSnackBar(
        title: 'Success',
        message: 'Record deleted successfully.',
      );
    } catch (e) {
      FullScreenLoader.stopLoading();

      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isDeleting.value = false;
    }
  }
}
