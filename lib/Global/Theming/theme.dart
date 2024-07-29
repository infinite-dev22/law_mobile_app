import 'package:flutter/material.dart';

import '../Variables/colors.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      surface: AppColors.appBgLightColor,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
    ));

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      surface: AppColors.appBgDarkColor,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
    ));
