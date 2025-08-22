import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData getTheme(bool isDark) {
    return ThemeData (
        useMaterial3: false,
        colorScheme: ColorScheme (
        brightness: isDark ? Brightness.dark : Brightness. light,
        primary: isDark ? AppColors.primaryDark : AppColors.primaryLight,
        onPrimary: isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight,
        secondary: isDark ? AppColors.secondaryDark : AppColors.secondaryLight,
        onSecondary: isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight,
        error: Colors.red, onError: Colors.white,
        surface: isDark ? AppColors.surfaceDark : AppColors.secondaryLight,
        onSurface: isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight,
    ),
    ); // ColorScheme ); // ThemeData
  }
}