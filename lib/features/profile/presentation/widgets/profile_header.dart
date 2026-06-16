import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/common/widgets/images/circular_image.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/image_strings.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              /// Profile picture
              CircularImage(
                image: AppImageStrings.userAvatar3,
                width: 130,
                height: 130,
              ),

              /// Edit icon
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    size: AppSizes.iconMd,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),

          /// Name
          Text(
            'Mostafa Al Moin',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),

          /// Email
          Text(
            'mostafaalmoin@example.com',
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          /// Role
          Container(
            margin: const EdgeInsets.only(top: AppSizes.md),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.sm,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
            ),
            child: Text(
              'Admin',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
