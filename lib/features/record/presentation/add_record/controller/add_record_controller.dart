import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddRecordController extends GetxController {
  /// Controllers
  final dateController = TextEditingController();
  final factoryController = TextEditingController();
  final truckController = TextEditingController();
  final fareController = TextEditingController();
  final loadController = TextEditingController();
  final unloadController = TextEditingController();
  final unloadPointController = TextEditingController();
  final itemController = TextEditingController();
  final remarksController = TextEditingController();
  final companyController = TextEditingController();

  /// State
  DateTime? selectedDate;

  /// Item options
  final List<String> itemOptions = ["Box", "Hanger", "-"];
  RxString selectedItem = ''.obs;

  /// Companies options
  final List<String> companies = [
    "Meghna Executive Holding",
    "Company B",
    "Company C",
  ];

  /// Total
  RxDouble totalAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();

    /// Auto calculate total
    fareController.addListener(calculateTotal);
    loadController.addListener(calculateTotal);
    unloadController.addListener(calculateTotal);
  }

  /// Pick Date
  void pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      selectedDate = picked;
      dateController.text = DateFormat('dd MMM yyyy').format(picked);
    }
  }

  /// Calculate Total
  void calculateTotal() {
    final fare = double.tryParse(fareController.text) ?? 0;
    final load = double.tryParse(loadController.text) ?? 0;
    final unload = double.tryParse(unloadController.text) ?? 0;

    totalAmount.value = fare + load + unload;
  }

  /// Save
  void saveRecord() {
    final data = {
      "date": dateController.text,
      "factory": factoryController.text,
      "truck": truckController.text,
      "fare": fareController.text,
      "load": loadController.text,
      "unload": unloadController.text,
      "item": itemController.text,
      "total": totalAmount.value,
    };

    debugPrint("Saved: $data");
  }

  @override
  void onClose() {
    dateController.dispose();
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
