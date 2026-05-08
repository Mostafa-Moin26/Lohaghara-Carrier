import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
    this.showBorder = true,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.cardRadiusMd),

      child: Container(
        padding: const EdgeInsets.all(AppSizes.md),

        decoration: BoxDecoration(
          border: showBorder
              ? Border(
                  bottom: BorderSide(
                    color: dark
                        ? AppColors.darkGrey
                        : AppColors.grey.withValues(alpha: 0.15),
                  ),
                )
              : null,
        ),

        child: Row(
          children: [
            /// 🔹 Leading Icon
            Container(
              padding: const EdgeInsets.all(AppSizes.sm),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              ),
              child: Icon(
                icon,
                size: AppSizes.iconMd,
                color: AppColors.primaryColor,
              ),
            ),

            const SizedBox(width: AppSizes.md),

            /// 🔹 Title + Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: dark ? AppColors.grey : AppColors.darkGrey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: AppSizes.sm),

            /// 🔹 Trailing
            trailing ??
                const Icon(
                  Iconsax.arrow_right_3,
                  size: AppSizes.iconSm,
                  color: AppColors.darkGrey,
                ),
          ],
        ),
      ),
    );
  }
}
