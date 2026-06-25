import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';

class AppFilterChip extends StatelessWidget {
  const AppFilterChip({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.icon,
    this.trailingIcon,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    /// Background
    final backgroundColor = isSelected
        ? AppColors.primaryColor
        : dark
        ? AppColors.darkerGrey
        : AppColors.white;

    /// Border
    final borderColor = isSelected
        ? AppColors.primaryColor
        : dark
        ? AppColors.darkGrey
        : AppColors.grey.withValues(alpha: 0.3);

    /// Text
    final textColor = isSelected
        ? AppColors.white
        : dark
        ? AppColors.white
        : AppColors.dark;

    return Padding(
      padding: const EdgeInsets.only(right: AppSizes.sm),
      child: Material(
        color: Colors.transparent,

        child: InkWell(
          borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
          onTap: onTap,

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,

            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.md,
              vertical: AppSizes.sm,
            ),

            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
              border: Border.all(color: borderColor),
            ),

            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Optional Icon
                if (icon != null) ...[
                  Icon(icon, size: 18, color: textColor),
                  const SizedBox(width: AppSizes.xs),
                ],

                /// Title
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,

                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                if (trailingIcon != null) ...[
                  const SizedBox(width: AppSizes.xs),
                  Icon(trailingIcon, size: 16, color: textColor),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
