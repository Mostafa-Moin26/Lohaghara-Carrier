import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';
import '../../styles/shadows.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    super.key,
    required this.title,
    this.subTitle,
    required this.icon,
    this.showButton = false,
    this.showSubTitle = true,
    this.onTap,
    this.backgroundColor,
    this.trailing,
    this.padding,
  });

  final String title;
  final String? subTitle;
  final IconData icon;

  final bool showButton;
  final bool showSubTitle;

  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        boxShadow: [AppShadows.horizontalProductShadow],
      ),
      child: Row(
        children: [
          /// Leading section
          Icon(icon, size: AppSizes.iconLg, color: AppColors.primaryDark),

          const SizedBox(width: AppSizes.md),

          /// Text section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                if (showSubTitle && subTitle != null) ...[
                  const SizedBox(height: AppSizes.xs),
                  Text(
                    subTitle!,
                    style: Theme.of(context).textTheme.labelMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),

          /// Trailing section
          if (trailing != null)
            trailing!
          else if (showButton)
            IconButton(
              onPressed: onTap,
              icon: const Icon(Iconsax.arrow_right_3),
              iconSize: AppSizes.iconMd,
            ),
        ],
      ),
    );
  }
}
