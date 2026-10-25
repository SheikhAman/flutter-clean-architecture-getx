import 'package:flutter/material.dart';
import 'package:flutter_core/core/storage/local_preferences.dart';
import 'package:get/get.dart';

class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = LocalPreferences.to;
    return Obx(
      () => TextButton.icon(
        onPressed: () => prefs.toggleLanguage(),
        icon: const Icon(Icons.language),
        label: Text(prefs.isEnglish.value ? 'EN' : 'BN'),
      ),
    );
  }
}
