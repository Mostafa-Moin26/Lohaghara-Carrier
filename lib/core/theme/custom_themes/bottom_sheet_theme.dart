import 'package:flutter/material.dart';

class AppBottomSheetTheme {
  AppBottomSheetTheme._();

  /// Customizable light bottom sheet theme for the app
  static BottomSheetThemeData lightBottomSheetTheme =
      const BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: Colors.white,
    modalBackgroundColor: Colors.white,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
  );

  /// Customizable dark bottom sheet theme for the app
  static BottomSheetThemeData darkBottomSheetTheme = const BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: Colors.black,
    modalBackgroundColor: Colors.black,
    constraints: BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
  );
}
