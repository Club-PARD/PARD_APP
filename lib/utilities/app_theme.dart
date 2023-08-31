import 'package:flutter/material.dart';
import 'package:pard_app/utilities/text_style.dart';
import 'package:pard_app/utilities/color_style.dart';

class AppTheme {
  AppTheme._();

  static final TextTheme _textTheme = TextTheme(
    displayLarge: displayLarge, //H3-24-B
    displayMedium: displayMedium, //H2-20-B
    displaySmall: displaySmall, //H1-18-SB
    headlineLarge: headlineLarge, //B6-16-B
    headlineMedium: headlineMedium, //B5-16-SB
    headlineSmall: headlineSmall, //B4-14-SB
    titleLarge: titleLarge, //B3-14-M
    titleMedium: titleMedium, //B2-12-SB
    titleSmall: titleSmall, //B1-12-M
  );

  static const ColorScheme _colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primaryOrange,
    onPrimary: primaryGreen,
    secondary: primaryPurple,
    onSecondary: primaryBlue,
    error: errorRed,
    onError: errorRed,
    background: backgroundColor,
    onBackground: whiteScale,
    surface: grayScale,
    onSurface: blackScale,
  );

  static final ThemeData regularTheme = ThemeData(
    fontFamily: 'Pretendard',
    textTheme: _textTheme,
    colorScheme: _colorScheme,
    focusColor: primaryBlue,
    buttonTheme: const ButtonThemeData(
      buttonColor: primaryBlue,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      elevation: 0.0,
      centerTitle: true,
      titleTextStyle: displayMedium.copyWith(color: whiteScale[100]),
    ),
    iconTheme: IconThemeData(
      color: whiteScale[100],
      size: 24,
    ),
    // bottomSheetTheme: const BottomSheetThemeData(
    //   backgroundColor: Colors.transparent,
    //   modalBackgroundColor: Colors.transparent,
    // ),
    // bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //   backgroundColor: const Color(0xff2A2A2A),
    //   selectedItemColor: primaryBlue,
    //   unselectedItemColor: grayScale[30],
    // ),
  );
}
