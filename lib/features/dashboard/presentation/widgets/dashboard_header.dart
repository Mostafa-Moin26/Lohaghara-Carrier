import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/common/widgets/images/circular_image.dart';
import 'package:lohaghara_carrier/core/popups/shimmer/shimmer.dart';
import 'package:lohaghara_carrier/features/profile/presentation/controller/user_controller.dart';
import 'package:lohaghara_carrier/routes/app_routes.dart';

import '../../../../core/constants/image_strings.dart';
import '../../../../core/helpers/helper_functions.dart';

class DashBoardHeader extends StatelessWidget {
  const DashBoardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    AppHelperFunctions.isDarkMode(context);
    final controller = Get.put(UserController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// WelCome msg
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, Mostafa Moin 👋',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text('Good Morning', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),

        /// User Avatar
        Obx(() {
          final networkImage = controller.user.value.profilePicture;
          final image = networkImage.isNotEmpty
              ? networkImage
              : AppImageStrings.userAvatar2;

          return controller.imageUploading.value
              ? ShimmerEffect(width: 65, height: 65, radius: 65)
              : CircularImage(
                  image: image,
                  width: 65,
                  height: 65,
                  isNetworkImage: networkImage.isNotEmpty,
                  onTap: () => Get.toNamed(AppRoutes.profileDetails),
                );
        }),
      ],
    );
  }
}
