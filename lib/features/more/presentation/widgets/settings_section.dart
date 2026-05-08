import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Section Title
        Padding(
          padding: const EdgeInsets.only(
            left: AppSizes.sm,
            bottom: AppSizes.sm,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: dark ? AppColors.white : AppColors.dark,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        /// Section Container
        Container(
          decoration: BoxDecoration(
            color: dark ? AppColors.darkerGrey : AppColors.white,
            borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}
