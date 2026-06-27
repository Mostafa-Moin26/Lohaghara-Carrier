import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';
import 'package:lohaghara_carrier/features/factory/presentation/controller/factory_controller.dart';

class FactoryHeaderInfo extends StatelessWidget {
  const FactoryHeaderInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FactoryController.instance;
    final dark = AppHelperFunctions.isDarkMode(context);

    return Obx(() {
      final month = DateFormat(
        'MMMM yyyy',
      ).format(controller.selectedMonth.value);

      final totalFactories = controller.filteredFactories.length;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
        child: Row(
          children: [
            /// Selected Month
            Row(
              children: [
                const Icon(
                  Icons.calendar_month_rounded,
                  size: 18,
                  color: AppColors.primaryColor,
                ),

                const SizedBox(width: 6),

                Text(
                  month,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),

            const Spacer(),

            /// Factory Count
            Text(
              '$totalFactories ${totalFactories == 1 ? 'Factory' : 'Factories'}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: dark ? AppColors.grey : AppColors.darkGrey,
              ),
            ),
          ],
        ),
      );
    });
  }
}
