import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';

class CalendarContainer extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;

  const CalendarContainer({
    super.key,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    final backgroundColor = isSelected
        ? AppColors.primaryColor
        : dark
        ? AppColors.darkerGrey
        : AppColors.white;

    final borderColor = isSelected
        ? AppColors.primaryColor
        : dark
        ? AppColors.darkGrey
        : Colors.grey.shade300;

    final iconColor = isSelected
        ? AppColors.white
        : dark
        ? AppColors.white
        : AppColors.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
            border: Border.all(color: borderColor),
          ),
          child: Icon(
            Iconsax.calendar_1,
            size: AppSizes.iconMd,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
