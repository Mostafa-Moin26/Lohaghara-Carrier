import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/common/widgets/texts/amount_price_text.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/core/validators/validators.dart';
import 'package:lohaghara_carrier/features/record/presentation/add_record/widgets/company_field.dart';
import 'package:lohaghara_carrier/features/record/presentation/add_record/widgets/item_bottom_sheet.dart';
import '../controller/add_record_controller.dart';

class AddRecordForm extends StatelessWidget {
  AddRecordForm({super.key});

  final controller = AddRecordController.instance;

  InputDecoration _dec({required String label, IconData? prefix}) {
    return InputDecoration(
      labelText: label,
      prefixIcon: prefix != null ? Icon(prefix) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.addRecordFormKey,
      child: Column(
        children: [
          /// Date
          TextFormField(
            controller: controller.dateController,
            validator: (value) => AppValidator.validateEmptyText('Date', value),
            readOnly: true,
            onTap: () => controller.pickDate(context),
            decoration: _dec(
              label: AppTextStrings.date,
              prefix: Iconsax.calendar,
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwInputFields),

          /// Company
          CompanyField(
            controller: controller.companyController,
            companies: ['Meghna Executive Holding'],
          ),
          const SizedBox(height: AppSizes.spaceBtwInputFields),

          /// Factory
          TextFormField(
            controller: controller.factoryController,
            validator: (value) =>
                AppValidator.validateEmptyText('Factory', value),
            decoration: _dec(
              label: AppTextStrings.factory,
              prefix: Iconsax.building_3,
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwInputFields),

          /// Truck
          TextFormField(
            controller: controller.truckController,
            validator: (value) =>
                AppValidator.validateEmptyText('Truck', value),
            decoration: _dec(
              label: AppTextStrings.truckNumber,
              prefix: Iconsax.truck,
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwInputFields),

          /// Fare
          TextFormField(
            controller: controller.fareController,
            validator: (value) => AppValidator.validateEmptyText('Fare', value),
            keyboardType: TextInputType.number,
            decoration: _dec(label: AppTextStrings.fare, prefix: Iconsax.money),
          ),
          const SizedBox(height: AppSizes.spaceBtwInputFields),

          /// Demurrage
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.loadController,
                  validator: (value) =>
                      AppValidator.validateEmptyText('Load Demmurage', value),
                  keyboardType: TextInputType.number,
                  decoration: _dec(label: AppTextStrings.loadDemmurage),
                ),
              ),
              const SizedBox(width: AppSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.unloadController,
                  validator: (value) => AppValidator.validateEmptyText(
                    'Unload Demmuarage',
                    value,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: _dec(label: AppTextStrings.unloadDemmurage),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwInputFields),

          /// Unload Point
          TextFormField(
            controller: controller.unloadPointController,
            validator: (value) =>
                AppValidator.validateEmptyText('Unload Point', value),
            decoration: _dec(
              label: AppTextStrings.unloadPoint,
              prefix: Iconsax.location,
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwInputFields),

          /// Item Dropdown
          TextFormField(
            controller: controller.itemController,
            validator: (value) => AppValidator.validateEmptyText('Item', value),
            decoration: InputDecoration(
              labelText: AppTextStrings.item,
              prefixIcon: const Icon(Iconsax.box),
              suffixIcon: IconButton(
                icon: const Icon(Iconsax.arrow_down_1, size: AppSizes.iconSm),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (_) => ItemBottomSheet(controller: controller),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: AppSizes.spaceBtwInputFields),

          /// Remarks
          TextFormField(
            controller: controller.remarksController,

            maxLines: 3,
            decoration: _dec(label: AppTextStrings.remarks),
          ),

          const SizedBox(height: AppSizes.spaceBtwInputFields),

          /// Total
          Obx(
            () => Container(
              padding: const EdgeInsets.all(AppSizes.md),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
                color: AppColors.primaryColor.withValues(alpha: 0.1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppTextStrings.totalAmount,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  AmountPriceText(
                    price: controller.totalAmount.value.toString(),
                    isCurrency: true,
                    isLarge: true,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: AppSizes.spaceBtwSections),

          /// Save
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.saveOrUpdateRecord(),
              child: Text(
                controller.isEditMode
                    ? 'Update Record'
                    : AppTextStrings.saveRecord,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
