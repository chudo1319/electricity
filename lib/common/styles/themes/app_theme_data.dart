import 'package:flutter/material.dart';

import '../app_sizes.dart';
import '../colors/app_color_scheme.dart';
import '../text/app_text_scheme.dart';


/// Class of the app themes data.
abstract class AppThemeData {
  const AppThemeData._();

  /// Dark theme configuration.
  static final darkTheme = ThemeData(
    extensions: [
      _darkColorScheme,
      AppTextScheme.base(_darkColorScheme.onSurface),
    ],
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: _darkColorScheme.primary,
      onPrimary: _darkColorScheme.onPrimary,
      secondary: _darkColorScheme.secondary,
      onSecondary: _darkColorScheme.onSecondary,
      error: _darkColorScheme.danger,
      onError: _darkColorScheme.onDanger,
      background: _darkColorScheme.background,
      onBackground: _darkColorScheme.onBackground,
      surface: _darkColorScheme.background,
      onSurface: _darkColorScheme.onSurface,
    ),
    textTheme: TextTheme(
      // Text field text style
      bodyLarge: AppTextScheme.base()
          .regular24
          .copyWith(color: _darkColorScheme.textField, height: 33 / 24),
    ),
    scaffoldBackgroundColor: _darkColorScheme.background,
    appBarTheme: AppBarTheme(
      color: _darkColorScheme.primary,
      elevation: AppSizes.double0,
      iconTheme: IconThemeData(
        color: _darkColorScheme.onPrimary,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _darkColorScheme.background,
      selectedItemColor: _darkColorScheme.primary,
      unselectedItemColor: _darkColorScheme.onBackground,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: _darkColorScheme.primary,
      contentTextStyle: TextStyle(
        color: _darkColorScheme.onPrimary,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: _darkColorScheme.frameTextFieldSecondary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(25, 17, 25, 17),
      fillColor: _darkColorScheme.surface,
      hintStyle: AppTextScheme.base().regular24.copyWith(color: _darkColorScheme.textFieldLabel),
      labelStyle: AppTextScheme.base().regular24.copyWith(color: _darkColorScheme.textFieldLabel),
      floatingLabelStyle: AppTextScheme.base().regular16.copyWith(
        color: _darkColorScheme.textFieldLabel,
        fontSize: 18,
      ),
      errorStyle: AppTextScheme.base().regular16.copyWith(
        color: _darkColorScheme.danger,
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(AppSizes.double16),
      ),
    ),
  );

  static final _darkColorScheme = AppColorScheme.dark();
}
