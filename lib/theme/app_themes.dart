import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'dark_color.dart';
import 'light_color.dart';

class AppThemes {
  // Light theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: LightColor().backgroundColor,
    appBarTheme: AppBarTheme(
      color: LightColor().backgroundColor,
      iconTheme: IconThemeData(
        color: DarkColor().iconColor,
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.ibmPlexSans(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: LightColor().headingColor,
      ),
      headlineMedium: GoogleFonts.ibmPlexSans(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: LightColor().headingColor,
      ),
      headlineSmall: GoogleFonts.ibmPlexSans(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: LightColor().headingColor,
      ),
      titleLarge: GoogleFonts.ibmPlexSans(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: LightColor().headingColor,
      ),
      bodyLarge: GoogleFonts.ibmPlexSans(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: LightColor().subHeadingColor,
      ),
      bodyMedium: GoogleFonts.ibmPlexSans(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: LightColor().subHeadingColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: LightColor().inputColor,
      border: InputBorder.none,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.red, // Error border color
          width: 1, // Border thickness for error
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.red, // Error border color when focused
          width: 0.5, // Border thickness for focused error
        ),
      ),
      errorMaxLines: 3,
    ),

    buttonTheme: ButtonThemeData(
      buttonColor: LightColor().buttonColor,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: LightColor().buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: Size(double.infinity, 48),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStateProperty.all(LightColor().iconColor),
      ),
    ),
    cardTheme: CardTheme(
      color: LightColor().innerBackground,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: LightColor().innerBackgroundBorderColor,
          width: 1,
        ),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: LightColor().innerBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  // Dark theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: DarkColor().backgroundColor,
    appBarTheme: AppBarTheme(
      color: DarkColor().backgroundColor,
      iconTheme: IconThemeData(
        color: DarkColor().iconColor,
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.ibmPlexSans(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: DarkColor().headingColor,
      ),
      headlineMedium: GoogleFonts.ibmPlexSans(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: DarkColor().headingColor,
      ),
      headlineSmall: GoogleFonts.ibmPlexSans(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: DarkColor().headingColor,
      ),
      titleLarge: GoogleFonts.ibmPlexSans(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: DarkColor().headingColor,
      ),
      bodyLarge: GoogleFonts.ibmPlexSans(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: DarkColor().subHeadingColor,
      ),
      bodyMedium: GoogleFonts.ibmPlexSans(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: DarkColor().subHeadingColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: DarkColor().inputColor,
      border: InputBorder.none,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.red, // Error border color
          width: 1, // Border thickness for error
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.red, // Error border color when focused
          width: 0.5, // Border thickness for focused error
        ),
      ),
      errorMaxLines: 3,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: DarkColor().buttonColor,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: DarkColor().buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: Size(double.infinity, 50),
      ),
    ),
    cardTheme: CardTheme(
      color: DarkColor().innerBackground,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: DarkColor().borderColor,
          width: 1,
        ),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: DarkColor().innerBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
