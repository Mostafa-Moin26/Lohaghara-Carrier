import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';

class AppCheckboxTheme {
  AppCheckboxTheme._();

  /// Customizable light checkbox theme for the app
  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white; // Color of the check icon when selected
      }
      return Colors.black; // No check icon when not selected
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primaryColor; // Background color when selected
      }
      return Colors.transparent; // Background color when not selected
    }),
  );

  /// Customizable dark checkbox theme for the app
  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white; // Color of the check icon when selected
      }
      return Colors.black; // No check icon when not selected
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primaryColor; // Background color when selected
      }
      return Colors.transparent; // Background color when not selected
    }),
  );
}
