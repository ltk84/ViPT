import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColor {
  AppColor._();
  static const Color primaryColor = Colors.red;
  static const Color secondaryColor = Color(0xff36f468);
  static const Color lightModeBackgroundColor = Colors.white;
  static const Color lightModeTextColor = Color(0xFF1B1B1B);
  static const Color darkModeBackgroundColor = Color(0xFF1B1B1B);
  static const Color darkModeTextColor = Colors.white;
  static const double subTextOpacity = 0.5;
  static const double disabledTextOpacity = 0.35;
  static const double disabledIconOpacity = 0.25;
  static const Color buttonForegroundColor = Colors.white;

  // Component color
  static const Color lightModeProgressIndicatorColor = Color(0xffe4e4e4);
  static const Color darkModeProgressIndicatorColor =
      Color(0xffe4e4e4); // Chưa implement
  static const Color lightModeTextFieldFill = Color(0xffe4e4e4);
  static const Color darkModeTextFieldFill =
      Color(0xffe4e4e4); // Chưa implement
  static const Color lightModeTextFieldUnderlineColor = Color(0xffe4e4e4);
  static const Color darkModeTextFieldUnderlineColor =
      Color(0xffe4e4e4); // Chưa implement
  static const Color lightModeListTileButtonColor = Color(0xFFf8f8f8);
  static const Color darkModeListTileButtonColor =
      Color(0xfff8f8f8); // Chưa implement

  // Extra Color field (static)
  static const Color googleButtonBackgroundColor = Colors.white;
  static const Color googleButtonForegroundColor = Color(0xFF1B1B1B);
  static const Color facebookButtonBackgroundColor = Color(0xff1877F2);
  static const Color facebookButtonForegroundColor = Colors.white;

  // static Color get backgroundColor => (Get.isDarkMode) ? darkBackgroundColor : lightBackgroundColor;
  //
  static Color get textColor =>
      (Get.isDarkMode) ? darkModeTextColor : lightModeTextColor;
  static Color get progressIndicatorColor => (Get.isDarkMode)
      ? darkModeProgressIndicatorColor
      : lightModeProgressIndicatorColor;
  static Color get textFieldFill =>
      (Get.isDarkMode) ? darkModeTextFieldFill : lightModeTextFieldFill;
  static Color get textFieldUnderlineColor => (Get.isDarkMode)
      ? darkModeTextFieldUnderlineColor
      : lightModeTextFieldUnderlineColor;
  static Color get listTileButtonColor => (Get.isDarkMode)
      ? darkModeListTileButtonColor
      : lightModeListTileButtonColor;
  //
  // static Color get disabledTextColor => (Get.isDarkMode) ? darkTextColor.withOpacity(disabledTextOpacity) : lightTextColor.withOpacity(disabledTextOpacity);
  //
  // static Color get disabledIconColor => (Get.isDarkMode) ? darkTextColor.withOpacity(disabledIconOpacity) : lightTextColor.withOpacity(disabledIconOpacity);
  //
  // static Color get indicatorCircularColour => (Get.isDarkMode) ? indicatorCircularDarkModeColour : indicatorCircularLightModeColour;
  //
  // static const Color lightBackgroundColor = Color(0xFFFFFFFF);
  // static const Color lightDeepBackgroundColor = Color(0xFFF0F2F5);
  // static const Color lightTextColor = Color(0xFF000000);
  //
  // static const Color darkBackgroundColor = Color(0xFF242526);
  // static const Color darkDeepBackgroundColor = Color(0xFF18191A);
  // static const Color darkTextColor = Color(0xFFFFFFFF);
  //
  // static const Color inflowTextColor = Color(0x1E88E5FF);
  // static const Color outflowTextColor = Color(0xE53935FF);

  // static const Color secondaryButtonBGColor = Color(0x0B0A13FF);
  //
  // static const Color appbarColouredBorder = Color(0xFFBDBDBD);
  //
  // static const Color indicatorCircularLightModeColour = Color(0xFFF57C00);
  // static const Color indicatorCircularDarkModeColour = Color(0xFFFAFAFA);
  //
  // static const Color textFieldBackgroundDarkColor = Color(0xFF242526);
  // static const Color textFieldBackgroundLightColor = Color(0xFF38305F);
}
