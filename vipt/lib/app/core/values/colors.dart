import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColor {
  AppColor._();
  static const Color primaryColor = Colors.red;
  static Color? primaryColorDark = Colors.red[900];
  static Color? primaryColorLight = Colors.red[200];
  static const Color secondaryColor = Color(0xff00C734);
  static const Color lightModeBackgroundColor = Colors.white;
  static const Color lightModeTextColor = Color(0xFF1B1B1B);
  static const Color darkModeBackgroundColor = Color(0xFF1B1B1B);
  static const Color darkModeTextColor = Colors.white;
  static const Color lightSecondaryBackgroudColor = Color(0xffeeeeee);
  static const Color darkSecondaryBackgroudColor = Color(0xffeeeeee);

  static const double subTextOpacity = 0.5;
  static const double disabledTextOpacity = 0.35;
  static const double disabledIconOpacity = 0.25;
  static const Color buttonForegroundColor = Colors.white;
  static const Color lightModeAccentTextColor = Colors.white;
  static const Color lightModeAccentTextLightColor = Color(0xddffffff);
  static const Color darkModeAccentTextColor = Color(0xff1b1b1b);
  static const Color darkModeAccentTextLightColor = Color(0xdd1b1b1b);
  static Color lightModeShadowColor = Colors.black.withOpacity(0.1);
  static Color darkModeShadowColor = Colors.white.withOpacity(0.1);
  static Color disableButtonColor = Colors.grey;

  // Workout Plan
  static const Color logWeightButtonColor = Color(0xff42C988);

  // Profile
  static const Color profileBackgroundColor = Color(0xffeeeeee);
  static const Color statisticExerciseTitleColor = Color(0xff4E0909);
  static const Color statisticExerciseDescriptionColor = Color(0xA84E0909);
  static Color statisticExerciseBarColor =
      primaryColorDark!.withOpacity(subTextOpacity);
  static const Color statisticExerciseBackgroundColor = Color(0xffef9a9a);
  static const Color statisticExerciseForegroundColor = Color(0xddffffff);

  static const Color statisticNutritionTitleColor = Color(0xff0F3300);
  static const Color statisticNutritionDescriptionColor = Color(0xA80F3300);
  static Color statisticNutritionBarColor =
      nutriDarkBackgroundColor.withOpacity(subTextOpacity);
  static const Color statisticNutritionBackgroundColor = Color(0xff75D6AC);
  static const Color statisticNutritionForegroundColor = Color(0xddffffff);

  static const Color statisticWaterTitleColor = Color(0xff152B51);
  static const Color statisticWaterDescriptionColor = Color(0xA8152B51);
  static Color statisticWaterBarColor =
      waterDarkBackgroundColor.withOpacity(subTextOpacity);
  static const Color statisticWaterBackgroundColor = Color(0xff759FF0);
  static const Color statisticWaterForegroundColor = Color(0xddffffff);

  static const Color weightTrackingTitleColor = Color(0xff02553E);
  static const Color weightTrackingDescriptionColor = Color(0xA802553E);
  static Color weightTrackingBarColor =
      weightTrackingTitleColor.withOpacity(subTextOpacity);
  static const Color weightTrackingBackgroundColor = Color(0xffB4FDEA);
  static const Color weightTrackingForegroundColor = Color(0xdd1b1b1b);
  static const Color weightTrackingBorderColor = Color(0xdd1b1b1b);
  static const List<Color> weightTrackingGradientColors = [
    Color(0xff23b6e6),
    Color(0xff02d39a),
  ];

  // Daily Plan colors
  static const Color nutriBackgroundColor = Color(0xff42C988);
  static const Color nutriDarkBackgroundColor = Color(0xff1E7200);
  static const Color exerciseBackgroundColor = Color(0xffF44336);
  static const Color waterBackgroundColor = Color(0xff437DEC);
  static const Color waterDarkBackgroundColor = Color(0xff3468CC);
  static const Color stepTrackingBackgroundColor = Color(0xff864BD0);
  static const Color stepTrackingDarkBackgroundColor = Color(0xff7602D1);
  static const Color fastingBackgroundColor = Color(0xffDD6D1C);
  static const Color fastingLightBackgroundColor = Color(0xffFF961B);
  static const Color fastingLightSecondaryBackgroundColor = Color(0xffFFDBB0);
  static const Color ingredientTileColor = Color(0xffF2F1F1);

  // Cube colors
  static const Color carbCubeColor = Color(0xff2CCCAF);
  static const Color proteinCubeColor = Color(0xffF49B69);
  static const Color fatCubeColor = Color(0xff908677);

  // Complete session gradient colors
  static Color completeSessionSecondaryFilterColor =
      const Color(0xff91E39A).withOpacity(0.63);
  static Color completeSessionFilterColor =
      const Color(0xff00C734).withOpacity(0.49);
  static Gradient completeSessionGradient = LinearGradient(
    begin: const Alignment(0.0, -1.0),
    end: const Alignment(0.0, 0.6),
    colors: [
      Colors.white.withOpacity(0.80),
      Colors.white.withOpacity(0.79),
      Colors.white.withOpacity(0.58),
      Colors.white.withOpacity(0.0),
    ],
  );

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

  static const Color mediaButtonColor = Color(0xffF68080);

  static const Color timerRingColor = Color(0xffe4e4e4);

  static const Color workoutTimerPlayingFill = Color(0xffFF675E);
  static Color workoutTimerStopFill = const Color(0xffFF675E).withOpacity(0.24);
  static const Color workoutTimerReadyFill = Color(0xffFFB36C);
  static const Color workoutTimerRestFill = Color(0xffBEE15A);

  static const Color workoutTimerPlayingIndicatorColor = Color(0xffCE5750);
  static Color workoutTimerStopIndicatorColor =
      const Color(0xffCE5750).withOpacity(0.56);
  static const Color workoutTimerReadyIndicatorColor = Color(0xffE38415);
  static const Color workoutTimerRestIndicatorColor = Color(0xff8ACE54);

  static const Color collectionTimerFill = Color(0xffCE5750);
  static const Color collectionTimerIndicatorColor = Color(0xffC08484);
  static const Color collectionTimerBackgroundColor = Color(0xffEBDADA);

  static const Color pauseStatusOverlayTitleColor = Color(0xffF44444);
  static const Color readyStatusOverlayTitleColor = Color(0xffF48444);
  static const Color restStatusOverlayTitleColor = Color(0xff78BC09);

  // Extra Color field (static)
  static const Color googleButtonBackgroundColor = Colors.white;
  static const Color googleButtonForegroundColor = Color(0xFF1B1B1B);
  static const Color facebookButtonBackgroundColor = Color(0xff1877F2);
  static const Color facebookButtonForegroundColor = Colors.white;
  static const Color resumeActionConfirmationAlertColor = Color(0xff78BC09);

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
  static Color get accentTextColor =>
      (Get.isDarkMode) ? darkModeAccentTextColor : lightModeAccentTextColor;
  static Color get accentTextLightColor => (Get.isDarkMode)
      ? darkModeAccentTextLightColor
      : lightModeAccentTextLightColor;
  static Color get shadowColor =>
      (Get.isDarkMode) ? darkModeShadowColor : lightModeShadowColor;
  static Color get secondaryBackgroudColor => (Get.isDarkMode)
      ? darkSecondaryBackgroudColor
      : lightSecondaryBackgroudColor;
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
