import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageService extends GetxService {
  static const english = Locale('en', 'US');
  static const bangla = Locale('bn', 'BD');

  void changeLanguage(bool isEnglish) {
    if (isEnglish) {
      Get.updateLocale(english);
    } else {
      Get.updateLocale(bangla);
    }
  }
}
