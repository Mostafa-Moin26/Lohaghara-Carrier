import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/common/widgets/images/circular_image.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/image_strings.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/popups/shimmer/shimmer.dart';
import 'package:lohaghara_carrier/features/profile/presentation/controller/user_controller.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              Obx(() {
                final networkImage = controller.user.value.profilePicture;
                final image = networkImage.isNotEmpty
                    ? networkImage
                    : AppImageStrings.emptyProfilePicture;

                return controller.imageUploading.value
                    ? ShimmerEffect(width: 130, height: 130, radius: 130)
                    : CircularImage(
                        image: image,
                        width: 130,
                        height: 130,
                        isNetworkImage: networkImage.isNotEmpty,
                      );
              }),

              /// Edit icon
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    iconSize: 10,
                    onPressed: () => controller.uploadUserProfilePicture(),
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      size: AppSizes.iconMd,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),

          /// Name
          Obx(
            () => Text(
              controller.user.value.fullName,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 4),

          /// Email
          Text(
            controller.user.value.email,
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
