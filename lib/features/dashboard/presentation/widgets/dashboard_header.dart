import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/image_strings.dart';
import '../../../core/helpers/helper_functions.dart';

class DashBoardHeader extends StatelessWidget {
  const DashBoardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
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
        Container(
          width: AppHelperFunctions.screenWidth() * 0.12,
          height: AppHelperFunctions.screenWidth() * 0.12,
          decoration: BoxDecoration(
            border: Border.all(
              color: dark ? AppColors.white : AppColors.primaryDark,
              width: 1.5,
            ),
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Image(
              width: double.infinity,
              height: double.infinity,
              image: AssetImage(AppImageStrings.userAvatar3),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
