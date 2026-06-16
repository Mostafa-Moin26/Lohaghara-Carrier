import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';

class ProfileInfoSection extends StatelessWidget {
  const ProfileInfoSection({
    super.key,
    required this.title,
    required this.children,
  });
  final String title;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: dark ? AppColors.darkerGrey : AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.cardRadiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          ...children,
        ],
      ),
    );
  }
}
