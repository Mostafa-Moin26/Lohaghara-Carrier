import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';

class RecordFilterChip extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const RecordFilterChip({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    /// Background color
    final backgroundColor = isSelected
        ? AppColors.primaryColor
        : dark
        ? AppColors.darkerGrey
        : AppColors.white;

    /// Border color
    final borderColor = isSelected
        ? AppColors.primaryColor
        : dark
        ? AppColors.darkGrey
        : AppColors.grey.withValues(alpha: 0.3);

    /// Text color
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
              border: Border.all(color: borderColor, width: 1),
            ),
            child: Center(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
