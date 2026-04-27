import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/common/styles/shadows.dart';
import 'package:lohaghara_carrier/core/common/widgets/texts/amount_price_text.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';

class DashboardStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final bool isCurrency;

  const DashboardStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    this.isCurrency = false,
  });

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.all(AppSizes.defaultPadding),
      decoration: BoxDecoration(
        color: dark ? AppColors.darkerGrey : AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        boxShadow: [AppShadows.horizontalProductShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // / Icon Container
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: iconColor),
          ),
          const SizedBox(height: 10),

          /// Title
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(color: Colors.grey.shade600),
          ),

          const SizedBox(height: AppSizes.sm),

          /// Amount / Price
          AmountPriceText(price: value, isLarge: true, isCurrency: isCurrency),

          const SizedBox(height: AppSizes.sm),

          /// Subtitle
          Text(
            subtitle,
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.copyWith(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
