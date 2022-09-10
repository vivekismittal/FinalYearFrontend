import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const ColorScheme lightColorScheme = ColorScheme(
    background: Color(0xffffffff),
    brightness: Brightness.light,
    error: Color(0xffba1b1b),
    errorContainer: Color(0xffffdad4),
    inversePrimary: Color(0xff9ccaff),
    inverseSurface: Color(0xff2f3033),
    onBackground: Color(0xff001f24),
    onError: Color(0xffffffff),
    onErrorContainer: Color(0xff410001),
    onInverseSurface: Color(0xfff1f0f4),
    onPrimary: Color(0xffffffff),
    onPrimaryContainer: Color(0xff002114),
    onSecondary: Color(0xffffffff),
    onSecondaryContainer: Color(0xff001e2e),
    onSurface: Color(0xff1b1b1b),
    onSurfaceVariant: Color(0xff00497e),
    onTertiary: Color(0xffffffff),
    onTertiaryContainer: Color(0xff001f24),
    outline: Color(0xff73777f),
    primary: Color(0xff18d39b),
    primaryContainer: Color(0xff9ef4cd),
    secondary: Color(0xff2f4858),
    secondaryContainer: Color(0xffc4e7ff),
    shadow: Color(0xff000000),
    surface: Color(0xfffdfcff),
    surfaceTint: Color(0xff0061a6),
    surfaceVariant: Color(0xffe9f1ff),
    tertiary: Color(0xfff2f2f2),
    tertiaryContainer: Color(0xff92f1ff),
  );
  late CardTheme lightCardTheme;
  late ThemeData lightThemeData;
  late TextTheme lightTextTheme;
  late AppBarTheme lightAppBarTheme;
  AppTheme() {
    TextStyle textStyle = GoogleFonts.lato();
    lightAppBarTheme = AppBarTheme(
      backgroundColor: lightColorScheme.secondary,
    );
    lightTextTheme = TextTheme(
      bodyMedium: textStyle.copyWith(fontSize: 16),
      bodySmall: textStyle.copyWith(fontSize: 12),
      displaySmall: textStyle.copyWith(fontSize: 20),
      displayMedium: textStyle.copyWith(fontSize: 24),
    );
    lightCardTheme = CardTheme(
      color: AppTheme.lightColorScheme.tertiary,
      shadowColor: lightColorScheme.shadow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );

    lightThemeData = ThemeData(
      scaffoldBackgroundColor: lightColorScheme.surface,
      appBarTheme: lightAppBarTheme,
      textTheme: lightTextTheme,
      brightness: Brightness.light,
      colorScheme: lightColorScheme,
      primaryColor: lightColorScheme.primary,
      errorColor: lightColorScheme.error,
      backgroundColor: lightColorScheme.background,
      cardTheme: lightCardTheme,
    );
  }
}
