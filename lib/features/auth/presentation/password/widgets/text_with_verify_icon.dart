import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';

class TextWithVerifyIcon extends StatelessWidget {
  const TextWithVerifyIcon({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// verify icon
        Icon(
          Iconsax.verify5,
          size: AppSizes.iconMd,
          color: AppColors.primaryLight,
        ),
        const SizedBox(width: AppSizes.sm),

        /// Text
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
