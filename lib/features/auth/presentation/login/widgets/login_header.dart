import 'package:flutter/material.dart';

import '../../../../core/constants/image_strings.dart';
import '../../../../core/constants/text_strings.dart';
import '../../../../core/helpers/helper_functions.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        /// Logo
        Image(
          width: AppHelperFunctions.screenWidth() * 0.35,
          height: AppHelperFunctions.screenHeight() * 0.2,
          image: AssetImage(AppImageStrings.appLogo),
        ),

        /// Title
        Text(
          AppTextStrings.loginTitle,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
