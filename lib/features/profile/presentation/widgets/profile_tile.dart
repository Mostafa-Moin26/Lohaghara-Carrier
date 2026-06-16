import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.showArrow = true,
  });
  final IconData icon;
  final String title;
  final String value;
  final bool showArrow;
  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: AppColors.primaryColor,
              size: AppSizes.iconMd,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: dark ? AppColors.white : AppColors.black,
                  ),
                ),
              ],
            ),
          ),
          if (showArrow)
            Icon(
              Icons.arrow_forward_ios,
              size: AppSizes.iconSm,
              color: dark ? AppColors.white : AppColors.black,
            ),
        ],
      ),
    );
  }
}
