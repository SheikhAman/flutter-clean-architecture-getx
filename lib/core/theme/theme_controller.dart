import 'package:flutter/material.dart';
import 'package:flutter_core/core/storage/local_preferences.dart';
import 'package:flutter_core/core/theme/app_colors.dart';
import 'package:flutter_core/core/theme/app_theme.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final LocalPreferences prefs = LocalPreferences.to;

  ThemeData get lightTheme =>
      AppTheme.fromSeed(seed: prefs.primaryColor, isDark: false);

  ThemeData get darkTheme =>
      AppTheme.fromSeed(seed: prefs.primaryColor, isDark: true);

  Future<void> setSeedIndex(int index) => prefs.setPrimaryColorIndex(index);

  Future<void> toggleDark() => prefs.toggleTheme();

  List<Color> get seeds => AppColors.seeds;
}
