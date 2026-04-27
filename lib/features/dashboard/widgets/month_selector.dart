import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';
import 'package:lohaghara_carrier/core/utils/date_formatter.dart';
import 'package:lohaghara_carrier/features/dashboard/controllers/dashboard_controller.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class MonthSelector extends StatelessWidget {
  MonthSelector({super.key});

  final controller = Get.find<DashboardController>();

  Future<void> pickMonth(BuildContext context) async {
    final dark = AppHelperFunctions.isDarkMode(context);
    final picked = await showMonthPicker(
      context: context,
      initialDate: controller.selectedMonth.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),

      monthPickerDialogSettings: MonthPickerDialogSettings(
        // Dialog container customization
        dialogSettings: PickerDialogSettings(
          dialogRoundedCornersRadius: AppSizes.buttonRadius,
          dialogBackgroundColor: dark ? AppColors.black : AppColors.white,
        ),

        // Top blue header customization
        headerSettings: PickerHeaderSettings(
          headerBackgroundColor: AppColors.primaryDark,

          headerCurrentPageTextStyle: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),

          headerSelectedIntervalTextStyle: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: Colors.white70, fontSize: 16),
        ),

        // Month button customization
        dateButtonsSettings: PickerDateButtonsSettings(
          selectedMonthBackgroundColor: AppColors.primaryDark,
          selectedMonthTextColor: AppColors.white,

          unselectedMonthsTextColor: Colors.grey,
          currentMonthTextColor: AppColors.primaryColor,

          monthTextStyle: Theme.of(context).textTheme.bodyLarge,
        ),

        // Bottom buttons customization
        actionBarSettings: PickerActionBarSettings(
          confirmWidget: Text(
            AppTextStrings.ok,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.primaryDark,
              fontWeight: FontWeight.bold,
            ),
          ),

          cancelWidget: Text(
            AppTextStrings.cancel,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
          ),
        ),
      ),
    );

    if (picked != null) {
      controller.updateSelectedMonth(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Obx(
      () => GestureDetector(
        onTap: () => pickMonth(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: dark ? AppColors.darkerGrey : AppColors.white,
            borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
            border: Border.all(
              color: AppColors.primaryDark.withValues(alpha: 0.5),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(DateFormatter.monthYear(controller.selectedMonth.value)),
              const SizedBox(width: AppSizes.spaceBtwSections),
              const Icon(Iconsax.arrow_down_1, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
