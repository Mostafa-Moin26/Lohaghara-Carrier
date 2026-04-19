import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';

class AppElevatedButtonTheme {
  AppElevatedButtonTheme._();

  /// Customizable light elevated button theme for the app
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: AppColors.buttonPrimary,
      foregroundColor: Colors.white,
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.grey,
      side: const BorderSide(color: AppColors.buttonPrimary),
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      textStyle: const TextStyle(
        fontSize: 16.0,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),
  );

  /// Customizable dark elevated button theme for the app
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: AppColors.buttonPrimary,
      foregroundColor: Colors.white,
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.grey,
      side: const BorderSide(color: AppColors.buttonPrimary),
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      textStyle: const TextStyle(
        fontSize: 16.0,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),
  );
}
