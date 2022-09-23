import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const ColorScheme colorScheme = ColorScheme(
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
    onTertiary: Color(0xff001f24),
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

  late AppBarTheme appBarTheme;
  late ElevatedButtonThemeData buttonTheme;
  late CardTheme cardTheme;
  late InputDecorationTheme inputDecorationTheme;
  late TextTheme textTheme;
  late ThemeData themeData;

  AppTheme() {
    textTheme = GoogleFonts.latoTextTheme(Typography.englishLike2021);
    appBarTheme = AppBarTheme(
      titleTextStyle:
          textTheme.headlineSmall!.copyWith(color: colorScheme.onSecondary),
      backgroundColor: colorScheme.secondary,
    );

    buttonTheme = ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return colorScheme.onTertiary;
          }
          if (states.contains(MaterialState.hovered)) {
            return colorScheme.onSecondary;
          }
          return colorScheme.onSecondaryContainer;
        }),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return colorScheme.tertiaryContainer;
          }
          if (states.contains(MaterialState.hovered)) {
            return colorScheme.secondary;
          }
          return colorScheme.secondaryContainer;
        }),
      ),
    );

    cardTheme = CardTheme(
      color: AppTheme.colorScheme.tertiary,
      shadowColor: colorScheme.shadow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );

    inputDecorationTheme = InputDecorationTheme(
      labelStyle: textTheme.titleMedium,
      hintStyle: textTheme.bodySmall,
      fillColor: colorScheme.surfaceVariant,
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.5,
          color: colorScheme.primary,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.5,
          color: colorScheme.primary,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: colorScheme.outline,
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: colorScheme.outline,
        ),
      ),
      focusColor: colorScheme.primary,
    );

    themeData = ThemeData(
      appBarTheme: appBarTheme,
      elevatedButtonTheme: buttonTheme,
      backgroundColor: colorScheme.background,
      brightness: Brightness.light,
      cardTheme: cardTheme,
      colorScheme: colorScheme,
      errorColor: colorScheme.error,
      inputDecorationTheme: inputDecorationTheme,
      primaryColor: colorScheme.primary,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: textTheme,
    );
  }
}



// static const TextTheme englishLike = TextTheme(
//     displayLarge: TextStyle(debugLabel: 'englishLike displayLarge 2021', inherit: false, fontSize: 57.0, fontWeight: FontWeight.w400, letterSpacing: -0.25, height: 1.12, textBaseline: TextBaseline.alphabetic, leadingDistribution: TextLeadingDistribution.even),
//     displayMedium: TextStyle(debugLabel: 'englishLike displayMedium 2021', inherit: false, fontSize: 45.0, fontWeight: FontWeight.w400, letterSpacing: 0.0, height: 1.16, textBaseline: TextBaseline.alphabetic, leadingDistribution: TextLeadingDistribution.even),
//     displaySmall: TextStyle(debugLabel: 'englishLike displaySmall 2021', inherit: false, fontSize: 36.0, fontWeight: FontWeight.w400, letterSpacing: 0.0, height: 1.22, textBaseline: TextBaseline.alphabetic, leadingDistribution: TextLeadingDistribution.even),
//     headlineLarge: TextStyle(debugLabel: 'englishLike headlineLarge 2021', inherit: false, fontSize: 32.0, fontWeight: FontWeight.w400, letterSpacing: 0.0, height: 1.25, textBaseline: TextBaseline.alphabetic, leadingDistribution: TextLeadingDistribution.even),
//     headlineMedium: TextStyle(debugLabel: 'englishLike headlineMedium 2021', inherit: false, fontSize: 28.0, fontWeight: FontWeight.w400, letterSpacing: 0.0, height: 1.29, textBaseline: TextBaseline.alphabetic, leadingDistribution: TextLeadingDistribution.even),
//     headlineSmall: TextStyle(debugLabel: 'englishLike headlineSmall 2021', inherit: false, fontSize: 24.0, fontWeight: FontWeight.w400, letterSpacing: 0.0, height: 1.33, textBaseline: TextBaseline.alphabetic, leadingDistribution: TextLeadingDistribution.even),
//     titleLarge: TextStyle(debugLabel: 'englishLike titleLarge 2021', inherit: false, fontSize: 22.0, fontWeight: FontWeight.w400, letterSpacing: 0.0, height: 1.27, textBaseline: TextBaseline.alphabetic, leadingDistribution: TextLeadingDistribution.even),
//     titleMedium: TextStyle(debugLabel: 'englishLike titleMedium 2021', inherit: false, fontSize: 16.0, fontWeight: FontWeight.w500, letterSpacing: 0.15, height: 1.50, textBaseline: TextBaseline.alphabetic, leadingDistribution: TextLeadingDistribution.even),
//     titleSmall: TextStyle(debugLabel: 'englishLike titleSmall 2021', inherit: false, fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 0.1, height: 1.43, textBaseline: TextBaseline.alphabetic, leadingDistribution: TextLeadingDistribution.even),
//     labelLarge: TextStyle(debugLabel: 'englishLike labelLarge 2021', inherit: false, fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 0.1, height: 1.43, textBaseline: TextBaseline.alphabetic, leadingDistribution: TextLeadingDistribution.even),
//     labelMedium: TextStyle(debugLabel: 'englishLike labelMedium 2021', inherit: false, fontSize: 12.0, fontWeight: FontWeight.w500, letterSpacing: 0.5, height: 1.33, textBaseline: TextBaseline.alphabetic, leadingDistribution: TextLeadingDistribution.even),
//     labelSmall: TextStyle(debugLabel: 'englishLike labelSmall 2021', inherit: false, fontSize: 11.0, fontWeight: FontWeight.w500, letterSpacing: 0.5, height: 1.45, textBaseline: TextBaseline.alphabetic, leadingDistribution: TextLeadingDistribution.even),
//     bodyLarge: TextStyle(debugLabel: 'englishLike bodyLarge 2021', inherit: false, fontSize: 16.0, fontWeight: FontWeight.w400, letterSpacing: 0.5, height: 1.50, textBaseline: TextBaseline.alphabetic, leadingDistribution: TextLeadingDistribution.even),
//     bodyMedium: TextStyle(debugLabel: 'englishLike bodyMedium 2021', inherit: false, fontSize: 14.0, fontWeight: FontWeight.w400, letterSpacing: 0.25, height: 1.43, textBaseline: TextBaseline.alphabetic, leadingDistribution: TextLeadingDistribution.even),
//     bodySmall: TextStyle(debugLabel: 'englishLike bodySmall 2021', inherit: false, fontSize: 12.0, fontWeight: FontWeight.w400, letterSpacing: 0.4, height: 1.33, textBaseline: TextBaseline.alphabetic, leadingDistribution: TextLeadingDistribution.even),
//   );