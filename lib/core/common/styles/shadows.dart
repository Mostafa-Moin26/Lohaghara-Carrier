import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class AppShadows {
  static final verticalProductShadow = BoxShadow(
    color: AppColors.black.withValues(alpha: 0.1),
    // blurRadius: 50,
    blurRadius: 50,
    // spreadRadius: 7,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );

  static final horizontalProductShadow = BoxShadow(
    color: AppColors.black.withValues(alpha: 0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );
}
