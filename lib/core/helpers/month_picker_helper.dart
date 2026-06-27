import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class MonthPickerHelper {
  MonthPickerHelper._();

  static Future<DateTime?> pickMonth({
    required BuildContext context,
    required DateTime initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final dark = AppHelperFunctions.isDarkMode(context);

    return await showMonthPicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime(2020),
      lastDate: lastDate ?? DateTime(2035),

      monthPickerDialogSettings: MonthPickerDialogSettings(
        /// ---------------- Dialog ----------------
        dialogSettings: PickerDialogSettings(
          dialogRoundedCornersRadius: 24,
          dialogBackgroundColor: dark ? AppColors.darkerGrey : AppColors.white,
        ),

        /// ---------------- Header ----------------
        headerSettings: PickerHeaderSettings(
          headerBackgroundColor: AppColors.primaryColor,

          headerCurrentPageTextStyle: Theme.of(context).textTheme.headlineSmall!
              .copyWith(color: Colors.white, fontWeight: FontWeight.w700),

          headerSelectedIntervalTextStyle: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: Colors.white70),
        ),

        /// ---------------- Month Buttons ----------------
        dateButtonsSettings: PickerDateButtonsSettings(
          monthTextStyle: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),

          selectedMonthBackgroundColor: AppColors.primaryColor.withValues(
            alpha: .12,
          ),

          selectedMonthTextColor: AppColors.primaryColor,

          currentMonthTextColor: AppColors.primaryColor,

          unselectedMonthsTextColor: dark ? AppColors.grey : AppColors.darkGrey,

          buttonBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),

        /// ---------------- Bottom Buttons ----------------
        actionBarSettings: PickerActionBarSettings(
          cancelWidget: Text(
            'Cancel',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.darkGrey,
              fontWeight: FontWeight.w600,
            ),
          ),

          confirmWidget: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryDark,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Apply',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
