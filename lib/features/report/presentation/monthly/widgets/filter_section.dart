import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:lohaghara_carrier/core/common/styles/shadows.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';
import 'package:lohaghara_carrier/features/company/data/models/company_model.dart';
import 'package:lohaghara_carrier/features/factory/data/models/factory_model.dart';
import 'package:lohaghara_carrier/features/report/presentation/summary/controller/monthly_bill_controller.dart';

class FiltersSection extends StatelessWidget {
  const FiltersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final controller = Get.put(MonthlyBillController());

    return Obx(
      () => Container(
        padding: const EdgeInsets.all(AppSizes.md),
        decoration: BoxDecoration(
          color: dark ? AppColors.darkerGrey : AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
          boxShadow: [AppShadows.horizontalProductShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔹 Company
            Text(
              AppTextStrings.company,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: AppSizes.sm),

            _selectionBox<CompanyModel>(
              context,
              icon: Iconsax.building_3,
              title: controller.selectedCompany.value?.name ?? "Select Company",
              showDownArrow: true,

              items: controller.companies
                  .map(
                    (company) => PopupMenuItem<CompanyModel>(
                      value: company,
                      child: Text(company.name),
                    ),
                  )
                  .toList(),

              onSelected: (company) async {
                await controller.updateSelectedCompany(company);
              },
            ),

            const SizedBox(height: AppSizes.spaceBtwItems),

            /// 🔹 From - To
            Row(
              children: [
                Expanded(
                  child: _selectionBox<FactoryModel>(
                    context,
                    icon: Iconsax.buildings_2,
                    title:
                        controller.selectedFactory.value?.name ??
                        "Select Factory",
                    subtitle: AppTextStrings.factory,
                    showDownArrow: true,

                    items: controller.factories
                        .map(
                          (factory) => PopupMenuItem<FactoryModel>(
                            value: factory,
                            child: Text(factory.name),
                          ),
                        )
                        .toList(),

                    onSelected: (factory) async {
                      await controller.updateSelectedFactory(factory);
                    },
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _monthSelectionBox(
                    context,
                    icon: Iconsax.calendar,
                    title: DateFormat(
                      'MMM yyyy',
                    ).format(controller.selectedMonth.value),
                    subtitle: AppTextStrings.month,
                    onTap: () async {
                      await controller.pickMonth(context);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSizes.spaceBtwItems),

            /// 🔹 Generate Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await controller.previewPdf();
                },
                icon: const Icon(Iconsax.chart_21),
                label: const Text(AppTextStrings.generateReport),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Selection Box (Reusable)
  Widget _selectionBox<T>(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    required List<PopupMenuEntry<T>> items,
    required ValueChanged<T> onSelected,
    required bool showDownArrow,
  }) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return PopupMenuButton<T>(
      itemBuilder: (_) => items,
      onSelected: onSelected,
      color: dark ? AppColors.darkerGrey : AppColors.white,
      elevation: 8,
      borderRadius: BorderRadius.circular(AppSizes.buttonRadius),

      child: Container(
        padding: const EdgeInsets.all(AppSizes.sm),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
          border: Border.all(
            color: dark ? AppColors.grey : AppColors.primaryDark,
          ),
        ),
        child: Row(
          children: [
            /// Icon
            Container(
              padding: const EdgeInsets.all(AppSizes.sm),
              decoration: BoxDecoration(
                color: dark
                    ? AppColors.primaryLight.withValues(alpha: .1)
                    : AppColors.primaryColor.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: AppSizes.iconSm,
                color: dark ? AppColors.primaryLight : AppColors.primaryColor,
              ),
            ),

            const SizedBox(width: AppSizes.sm),

            /// Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall!.copyWith(color: Colors.grey),
                    ),

                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),

            if (showDownArrow)
              const Icon(Iconsax.arrow_down_1, size: AppSizes.iconSm),
          ],
        ),
      ),
    );
  }

  Widget _monthSelectionBox(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
      child: Container(
        padding: const EdgeInsets.all(AppSizes.sm),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
          border: Border.all(
            color: dark ? AppColors.grey : AppColors.primaryDark,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSizes.sm),
              decoration: BoxDecoration(
                color: dark
                    ? AppColors.primaryLight.withValues(alpha: .1)
                    : AppColors.primaryColor.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: AppSizes.iconSm,
                color: dark ? AppColors.primaryLight : AppColors.primaryColor,
              ),
            ),

            const SizedBox(width: AppSizes.sm),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall!.copyWith(color: Colors.grey),
                    ),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
