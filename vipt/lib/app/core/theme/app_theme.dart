import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vipt/app/core/values/colors.dart';

class AppTheme {
  static final ElevatedButtonThemeData _elevatedButtonThemeData =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: AppColor.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    ),
  );

  static final TextButtonThemeData _secondaryButtonDarkThemeData =
      TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
  static final TextButtonThemeData _secondaryButtonLightThemeData =
      TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: AppColor.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );

  static final OutlinedButtonThemeData _outlinedButtonDarkThemeData =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      primary: Colors.white,
      side: const BorderSide(color: Colors.white, width: 2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
  );
  static final OutlinedButtonThemeData _outlinedButtonLightThemeData =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      primary: AppColor.primaryColor,
      side: const BorderSide(color: AppColor.primaryColor, width: 2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
  );

  // static TextTheme _textTheme(Color textColor) =>
  //     GoogleFonts.beVietnamProTextTheme();

  static TextTheme _textTheme(Color textColor) => TextTheme(
        headline1: GoogleFonts.beVietnamPro(
          color: textColor,
          fontSize: 28,
          fontWeight: FontWeight.w800,
        ),
        headline2: GoogleFonts.beVietnamPro(
          color: textColor,
          fontSize: 25,
          fontWeight: FontWeight.w700,
        ),
        headline3: GoogleFonts.beVietnamPro(
          color: textColor,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
        headline4: GoogleFonts.beVietnamPro(
          color: textColor,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        headline5: GoogleFonts.beVietnamPro(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        headline6: GoogleFonts.beVietnamPro(
          color: textColor,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        subtitle1: GoogleFonts.beVietnamPro(
          color: textColor,
          fontSize: 10.5,
          fontWeight: FontWeight.normal,
        ),
        subtitle2: GoogleFonts.beVietnamPro(
          color: textColor.withOpacity(0.5),
          fontSize: 10.5,
          fontWeight: FontWeight.w500,
        ),
        bodyText1: GoogleFonts.beVietnamPro(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodyText2: GoogleFonts.beVietnamPro(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        button: GoogleFonts.beVietnamPro(
          color: AppColor.buttonForegroundColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        caption: GoogleFonts.beVietnamPro(
          color: textColor,
          fontSize: 14,
        ),
        overline: GoogleFonts.beVietnamPro(
          color: textColor,
        ),
      );

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColor.primaryColor,
    ),
    appBarTheme: AppBarTheme(
      // color: AppColor.lightModeBackgroundColor,
      // backgroundColor: AppColor.primaryColor,
      iconTheme: const IconThemeData(color: AppColor.lightModeTextColor),
      titleTextStyle: GoogleFonts.beVietnamPro(
        color: AppColor.lightModeTextColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      elevation: 0,
    ),
    elevatedButtonTheme: _elevatedButtonThemeData,
    textButtonTheme: _secondaryButtonLightThemeData,
    outlinedButtonTheme: _outlinedButtonLightThemeData,
    primaryColor: AppColor.primaryColor,
    primaryColorDark: AppColor.primaryColor,
    primaryColorLight: AppColor.primaryColor,
    backgroundColor: AppColor.lightModeBackgroundColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.lightModeBackgroundColor,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: AppColor.lightModeTextColor,
      unselectedItemColor:
          AppColor.lightModeTextColor.withOpacity(AppColor.disabledTextOpacity),
      selectedIconTheme:
          const IconThemeData(color: AppColor.lightModeTextColor, opacity: 1),
      unselectedIconTheme: const IconThemeData(
          color: AppColor.lightModeTextColor,
          opacity: AppColor.disabledIconOpacity),
      selectedLabelStyle: GoogleFonts.beVietnamPro(
        fontSize: 10,
        fontWeight: FontWeight.normal,
      ),
      unselectedLabelStyle: GoogleFonts.beVietnamPro(
        fontSize: 10,
        fontWeight: FontWeight.normal,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColor.primaryColor,
      foregroundColor: Colors.white,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: AppColor.lightModeTextColor,
      unselectedLabelColor:
          AppColor.lightModeTextColor.withOpacity(AppColor.disabledTextOpacity),
      labelPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 12.0),
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(width: 2.0, color: AppColor.lightModeTextColor),
      ),
    ),
    textTheme: _textTheme(AppColor.lightModeTextColor),
    iconTheme: const IconThemeData(color: AppColor.lightModeTextColor),
    // scaffoldBackgroundColor: AppColor.lightDeepBackgroundColor,
    dividerColor:
        AppColor.lightModeTextColor.withOpacity(AppColor.disabledTextOpacity),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: const ColorScheme.dark().copyWith(
      primary: AppColor.primaryColor,
    ),
    appBarTheme: AppBarTheme(
      // color: AppColor.darkModeBackgroundColor,
      iconTheme: const IconThemeData(color: AppColor.darkModeTextColor),
      titleTextStyle: GoogleFonts.beVietnamPro(
        color: AppColor.darkModeTextColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      elevation: 0,
    ),
    elevatedButtonTheme: _elevatedButtonThemeData,
    textButtonTheme: _secondaryButtonDarkThemeData,
    outlinedButtonTheme: _outlinedButtonDarkThemeData,
    primaryColor: AppColor.primaryColor,
    primaryColorDark: AppColor.primaryColor,
    primaryColorLight: AppColor.primaryColor,
    backgroundColor: AppColor.darkModeBackgroundColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.darkModeBackgroundColor,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: AppColor.darkModeTextColor,
      unselectedItemColor:
          AppColor.darkModeTextColor.withOpacity(AppColor.disabledTextOpacity),
      selectedIconTheme:
          const IconThemeData(color: AppColor.darkModeTextColor, opacity: 1),
      unselectedIconTheme: const IconThemeData(
          color: AppColor.darkModeTextColor,
          opacity: AppColor.disabledIconOpacity),
      selectedLabelStyle: GoogleFonts.beVietnamPro(
        fontSize: 10,
        fontWeight: FontWeight.normal,
      ),
      unselectedLabelStyle: GoogleFonts.beVietnamPro(
        fontSize: 10,
        fontWeight: FontWeight.normal,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColor.primaryColor,
      foregroundColor: Colors.white,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: AppColor.darkModeTextColor,
      unselectedLabelColor:
          AppColor.darkModeTextColor.withOpacity(AppColor.disabledTextOpacity),
      labelPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 12.0),
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(width: 2.0, color: AppColor.darkModeTextColor),
      ),
    ),
    textTheme: _textTheme(AppColor.darkModeTextColor),
    iconTheme: const IconThemeData(color: AppColor.darkModeTextColor),
    // scaffoldBackgroundColor: AppColor.darkDeepBackgroundColor,
    dividerColor:
        AppColor.darkModeTextColor.withOpacity(AppColor.disabledTextOpacity),
  );
  static ThemeData currentTheme = (Get.isDarkMode ? darkTheme : lightTheme);
}
