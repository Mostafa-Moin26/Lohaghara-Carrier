import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:lohaghara_carrier/core/constants/image_strings.dart';
import 'package:lohaghara_carrier/core/helpers/network_manager.dart';
import 'package:lohaghara_carrier/core/popups/full_screen_loader.dart';
import 'package:lohaghara_carrier/core/popups/loaders.dart';
import 'package:lohaghara_carrier/features/factory/data/models/company_model.dart';
import 'package:lohaghara_carrier/features/factory/data/models/factory_model.dart';
import 'package:lohaghara_carrier/features/factory/data/repositories/company_repository.dart';
import 'package:lohaghara_carrier/features/factory/data/repositories/factory_repository.dart';

import 'package:lohaghara_carrier/features/record/data/models/record_model.dart';
import 'package:lohaghara_carrier/features/record/data/repositories/record_repository.dart';
import 'package:lohaghara_carrier/features/record/presentation/all_records/controllers/all_record_controller.dart';
import 'package:lohaghara_carrier/features/record/presentation/record_details/controller/record_details_controller.dart';

class AddRecordController extends GetxController {
  static AddRecordController get instance => Get.find();

  /// Repository
  final recordRepository = Get.put(RecordRepository());
  final companyRepository = Get.put(CompanyRepository());

  final factoryRepository = Get.put(FactoryRepository());

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
  final RxDouble totalAmount = 0.0.obs;

  /// Companies & Factories
  final companies = <CompanyModel>[].obs;
  final factories = <FactoryModel>[].obs;

  /// Edit Mode
  bool isEditMode = false;
  RecordModel? editingRecord;

  /// Items
  final List<String> itemOptions = ['Box', 'Hanger', '-'];

  @override
  void onInit() {
    super.onInit();

    checkEditMode();

    loadCompanies();

    fareController.addListener(calculateTotal);
    loadController.addListener(calculateTotal);
    unloadController.addListener(calculateTotal);
  }

  /// Check Edit Mode
  void checkEditMode() {
    if (Get.arguments != null && Get.arguments is RecordModel) {
      isEditMode = true;

      editingRecord = Get.arguments as RecordModel;

      loadRecordData(editingRecord!);
    }
  }

  /// Load companies
  Future<void> loadCompanies() async {
    final result = await companyRepository.fetchAllCompanies();

    companies.assignAll(result);
  }

  Future<void> onCompanySelected(String companyName) async {
    print('Company Selected => $companyName');

    final company = await companyRepository.getCompanyByName(companyName);

    if (company == null) {
      print('Company Not Found');
      return;
    }

    print('Company Id => ${company.id}');

    final result = await factoryRepository.fetchFactoriesByCompany(company.id);

    print('Factories Found => ${result.length}');

    factories.assignAll(result);
  }

  /// Prefill Data
  void loadRecordData(RecordModel record) {
    selectedDate = record.date;

    dateController.text = DateFormat('dd MMM yyyy').format(record.date);

    companyController.text = record.companyName;
    factoryController.text = record.factoryName;
    truckController.text = record.truckNumber;

    fareController.text = record.fare.toString();
    loadController.text = record.loadDemurrage.toString();
    unloadController.text = record.unloadDemurrage.toString();

    unloadPointController.text = record.unloadPoint;
    itemController.text = record.item;
    remarksController.text = record.remarks;

    totalAmount.value = record.totalAmount;
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

  /// Create or Update
  Future<void> saveOrUpdateRecord() async {
    if (isEditMode) {
      await updateRecord();
    } else {
      await saveRecord();
    }
  }

  /// Save Record
  Future<void> saveRecord() async {
    try {
      FullScreenLoader.openLoadingDialog(
        'Saving Record...',
        AppImageStrings.docerAnimation,
      );

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (!addRecordFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      /// Generate Month Key
      final monthKey = DateFormat(
        'yyyy-MM',
      ).format(selectedDate ?? DateTime.now());

      /// Get Or Create Company
      final company = await companyRepository.getOrCreateCompany(
        companyController.text.trim(),
      );

      /// Get Or Create Factory
      final factory = await factoryRepository.getOrCreateFactory(
        companyId: company.id,
        companyName: company.name,
        factoryName: factoryController.text.trim(),
      );

      /// Create Record
      final record = RecordModel(
        id: '',

        date: selectedDate ?? DateTime.now(),

        monthKey: monthKey,

        companyId: company.id,
        companyName: company.name,

        factoryId: factory.id,
        factoryName: factory.name,

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

      final savedRecord = await recordRepository.addRecord(record);

      if (Get.isRegistered<AllRecordController>()) {
        final controller = AllRecordController.instance;

        // insert new record on the beginning on the local records
        controller.records.insert(0, savedRecord);

        controller.applyFilters();
      }

      FullScreenLoader.stopLoading();

      Get.back();

      clearForm();

      AppLoaders.successSnackBar(
        title: 'Success',
        message: 'Record added successfully.',
      );
    } catch (e) {
      FullScreenLoader.stopLoading();

      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// Update Record
  Future<void> updateRecord() async {
    try {
      FullScreenLoader.openLoadingDialog(
        'Updating Record...',
        AppImageStrings.docerAnimation,
      );

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (!addRecordFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      final updatedRecord = editingRecord!.copyWith(
        date: selectedDate ?? editingRecord!.date,

        companyName: companyController.text.trim(),

        factoryName: factoryController.text.trim(),

        truckNumber: truckController.text.trim(),

        fare: double.tryParse(fareController.text.trim()) ?? 0,

        loadDemurrage: double.tryParse(loadController.text.trim()) ?? 0,

        unloadDemurrage: double.tryParse(unloadController.text.trim()) ?? 0,

        totalAmount: totalAmount.value,

        unloadPoint: unloadPointController.text.trim(),

        item: itemController.text.trim(),

        remarks: remarksController.text.trim(),

        updatedAt: DateTime.now(),
      );

      await recordRepository.updateRecord(updatedRecord);

      /// Update the record in the RecordDetailController
      if (Get.isRegistered<RecordDetailController>()) {
        RecordDetailController.instance.record(updatedRecord);
      }

      if (Get.isRegistered<AllRecordController>()) {
        final controller = AllRecordController.instance;

        final index = controller.records.indexWhere(
          (item) => item.id == updatedRecord.id,
        );

        if (index != -1) {
          controller.records[index] = updatedRecord;

          controller.records.refresh();

          controller.applyFilters();
        }
      }

      FullScreenLoader.stopLoading();

      Get.back(result: updatedRecord);

      AppLoaders.successSnackBar(
        title: 'Success',
        message: 'Record updated successfully.',
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

    isEditMode = false;
    editingRecord = null;
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
