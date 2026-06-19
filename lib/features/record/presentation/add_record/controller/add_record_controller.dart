import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:lohaghara_carrier/core/constants/image_strings.dart';
import 'package:lohaghara_carrier/core/helpers/network_manager.dart';
import 'package:lohaghara_carrier/core/popups/full_screen_loader.dart';
import 'package:lohaghara_carrier/core/popups/loaders.dart';

import 'package:lohaghara_carrier/features/record/data/models/record_model.dart';
import 'package:lohaghara_carrier/features/record/data/repositories/record_repository.dart';

class AddRecordController extends GetxController {
  static AddRecordController get instance => Get.find();

  /// Repository
  final recordRepository = Get.put(RecordRepository());

  /// Form Key
  final addRecordFormKey = GlobalKey<FormState>();

  /// Loading
  final isSaving = false.obs;

  /// Controllers
  final dateController = TextEditingController();
  final companyController = TextEditingController();
  final factoryController = TextEditingController();
  final truckController = TextEditingController();

  final fareController = TextEditingController();
  final loadController = TextEditingController();
  final unloadController = TextEditingController();

  final unloadPointController = TextEditingController();
  final itemController = TextEditingController();
  final remarksController = TextEditingController();

  /// Date
  DateTime? selectedDate;

  /// Total Amount
  RxDouble totalAmount = 0.0.obs;

  /// Items
  final List<String> itemOptions = ['Box', 'Hanger', '-'];

  @override
  void onInit() {
    super.onInit();

    fareController.addListener(calculateTotal);
    loadController.addListener(calculateTotal);
    unloadController.addListener(calculateTotal);
  }

  /// Pick Date
  Future<void> pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      selectedDate = picked;
      dateController.text = DateFormat('dd MMM yyyy').format(picked);
    }
  }

  /// Calculate Total
  void calculateTotal() {
    final fare = double.tryParse(fareController.text.trim()) ?? 0;

    final load = double.tryParse(loadController.text.trim()) ?? 0;

    final unload = double.tryParse(unloadController.text.trim()) ?? 0;

    totalAmount.value = fare + load + unload;
  }

  /// Save Record
  Future<void> saveRecord() async {
    try {
      /// Loader
      FullScreenLoader.openLoadingDialog(
        'Saving Record...',
        AppImageStrings.docerAnimation,
      );

      /// Internet Check
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      /// Validation
      if (!addRecordFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      /// Create Record
      final record = RecordModel(
        id: '',
        date: selectedDate ?? DateTime.now(),

        companyId: '',
        companyName: companyController.text.trim(),

        factoryId: '',
        factoryName: factoryController.text.trim(),

        truckNumber: truckController.text.trim(),

        fare: double.tryParse(fareController.text.trim()) ?? 0,

        loadDemurrage: double.tryParse(loadController.text.trim()) ?? 0,

        unloadDemurrage: double.tryParse(unloadController.text.trim()) ?? 0,

        totalAmount: totalAmount.value,

        unloadPoint: unloadPointController.text.trim(),

        item: itemController.text.trim(),

        remarks: remarksController.text.trim(),

        createdBy: '',

        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      /// Save
      await recordRepository.addRecord(record);

      /// Remove Loader
      FullScreenLoader.stopLoading();

      /// Back
      Get.back();

      /// Clear Form
      clearForm();

      /// Success
      AppLoaders.successSnackBar(
        title: 'Success',
        message: 'Record added successfully.',
      );
    } catch (e) {
      FullScreenLoader.stopLoading();

      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// Clear Form
  void clearForm() {
    dateController.clear();
    companyController.clear();
    factoryController.clear();
    truckController.clear();

    fareController.clear();
    loadController.clear();
    unloadController.clear();

    unloadPointController.clear();
    itemController.clear();
    remarksController.clear();

    selectedDate = null;
    totalAmount.value = 0;
  }

  @override
  void onClose() {
    dateController.dispose();
    companyController.dispose();
    factoryController.dispose();
    truckController.dispose();

    fareController.dispose();
    loadController.dispose();
    unloadController.dispose();

    unloadPointController.dispose();
    itemController.dispose();
    remarksController.dispose();

    super.onClose();
  }
}
