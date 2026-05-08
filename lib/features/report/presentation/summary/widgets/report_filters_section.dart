import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/common/styles/shadows.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';

class ReportFiltersSection extends StatelessWidget {
  const ReportFiltersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Container(
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

          _selectionBox(
            context,
            icon: Iconsax.building_3,
            title: "Meghna Executive Holding",
            onTap: () {},
            showDownArrow: true,
          ),

          const SizedBox(height: AppSizes.spaceBtwItems),

          /// 🔹 From - To
          Row(
            children: [
              Expanded(
                child: _selectionBox(
                  context,
                  icon: Iconsax.calendar,
                  title: "Jan 2026",
                  subtitle: AppTextStrings.from,
                  onTap: () {},
                  showDownArrow: false,
                ),
              ),

              const SizedBox(width: 10),

              const Icon(Icons.arrow_forward, size: 18),

              const SizedBox(width: 10),

              Expanded(
                child: _selectionBox(
                  context,
                  icon: Iconsax.calendar,
                  title: "Mar 2026",
                  subtitle: AppTextStrings.to,
                  onTap: () {},
                  showDownArrow: false,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSizes.spaceBtwItems),

          /// 🔹 Generate Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
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
    );
  }

  /// 🔹 Selection Box (Reusable)
  Widget _selectionBox(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    required bool showDownArrow,
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
            /// Icon
            Container(
              padding: const EdgeInsets.all(AppSizes.sm),
              decoration: BoxDecoration(
                color: dark
                    ? AppColors.primaryLight.withValues(alpha: 0.1)
                    : AppColors.primaryColor.withValues(alpha: 0.1),
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
}
