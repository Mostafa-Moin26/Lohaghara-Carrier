import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/common/styles/shadows.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';

class QuickActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const QuickActionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          final iconSize = width < 85 ? 18.0 : 22.0;
          final textSize = width < 85 ? 10.0 : 12.0;
          final iconPadding = width < 85 ? 10.0 : 12.0;

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            decoration: BoxDecoration(
              color: dark ? AppColors.darkerGrey : AppColors.white,
              borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
              boxShadow: [AppShadows.horizontalProductShadow],
            ),
            child: Column(
              children: [
                /// Icon Container
                Container(
                  padding: EdgeInsets.all(iconPadding),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
                  ),
                  child: Icon(icon, color: color, size: iconSize),
                ),

                const SizedBox(height: AppSizes.sm),

                /// Title
                Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: textSize,
                    color: dark ? AppColors.grey : AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
