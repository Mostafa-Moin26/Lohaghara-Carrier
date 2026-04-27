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
        /// Dialog Settings
        dialogSettings: PickerDialogSettings(
          dialogRoundedCornersRadius: 24,
          dialogBackgroundColor: dark ? AppColors.darkerGrey : AppColors.white,
        ),

        /// Minimal Header
        headerSettings: PickerHeaderSettings(
          headerBackgroundColor: Colors.transparent,

          headerCurrentPageTextStyle: Theme.of(context).textTheme.headlineSmall!
              .copyWith(
                fontWeight: FontWeight.w600,
                color: dark ? AppColors.white : AppColors.primaryDark,
              ),

          headerSelectedIntervalTextStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: dark ? AppColors.grey : AppColors.darkGrey),
        ),

        /// Month Buttons
        dateButtonsSettings: PickerDateButtonsSettings(
          monthTextStyle: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),

          /// Softer selected state
          selectedMonthBackgroundColor: AppColors.primaryColor.withValues(
            alpha: 0.08,
          ),

          selectedMonthTextColor: AppColors.primaryColor,

          currentMonthTextColor: AppColors.primaryColor,

          unselectedMonthsTextColor: dark ? AppColors.grey : AppColors.darkGrey,

          buttonBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: AppColors.primaryColor.withValues(alpha: 0.15),
            ),
          ),
        ),

        /// Bottom Action Buttons
        actionBarSettings: PickerActionBarSettings(
          cancelWidget: Text(
            AppTextStrings.cancel,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),

          confirmWidget: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              AppTextStrings.apply,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),

          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.md,
            vertical: AppSizes.sm,
          ),

          decoration: BoxDecoration(
            color: dark ? AppColors.darkerGrey : AppColors.white,

            borderRadius: BorderRadius.circular(16),

            border: Border.all(
              color: dark
                  ? AppColors.darkGrey
                  : AppColors.grey.withValues(alpha: 0.3),
            ),

            boxShadow: dark
                ? []
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),

          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                DateFormatter.monthYear(controller.selectedMonth.value),
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
              ),

              const SizedBox(width: 10),

              Icon(
                Iconsax.arrow_down_1,
                size: 16,
                color: dark ? AppColors.white : AppColors.primaryDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
