import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';
import 'package:lohaghara_carrier/core/helpers/month_picker_helper.dart';
import 'package:lohaghara_carrier/core/utils/date_formatter.dart';
import 'package:lohaghara_carrier/features/dashboard/presentation/controllers/dashboard_controller.dart';

class MonthSelector extends StatelessWidget {
  MonthSelector({super.key});

  final controller = DashboardController.instance;

  Future<void> pickMonth(BuildContext context) async {
    AppHelperFunctions.isDarkMode(context);

    final picked = await MonthPickerHelper.pickMonth(
      context: context,
      initialDate: controller.selectedMonth.value,
    );

    if (picked == null) return;

    if (picked.year == controller.selectedMonth.value.year &&
        picked.month == controller.selectedMonth.value.month) {
      return;
    }

    await controller.updateSelectedMonth(picked);
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
