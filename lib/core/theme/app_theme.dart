import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        primaryContainer: AppColors.primaryVariant,
        secondary: AppColors.secondary,
        secondaryContainer: AppColors.secondaryVariant,
        surface: AppColors.surface,
        background: AppColors.background,
        error: AppColors.error,
        onPrimary: AppColors.onPrimary,
        onSecondary: AppColors.onSecondary,
        onSurface: AppColors.onSurface,
        onBackground: AppColors.onBackground,
        onError: AppColors.onError,
      ),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        color: AppColors.primary,
        elevation: 4,
        iconTheme: IconThemeData(color: AppColors.onPrimary),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: AppColors.onPrimary, fontSize: 20, fontWeight: FontWeight.w500),
        bodyMedium: TextStyle(color: AppColors.onSurface, fontSize: 14),
      ),
    );
  }
}
