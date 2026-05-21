import 'package:flutter/material.dart';
import 'package:flutter_core/core/theme/app_colors.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalPreferences extends GetxService {

  static LocalPreferences get to => Get.find();

  final GetStorage _box = GetStorage();

  static Future<void> init() async {
    await GetStorage.init();
    Get.put(LocalPreferences());
  }

  // =========================
  // AUTH
  // =========================

  final token = ''.obs;
  final refreshToken = ''.obs;
  final isLoggedIn = false.obs;

  // =========================
  // USER
  // =========================

  final userId = ''.obs;
  final name = ''.obs;
  final email = ''.obs;
  final phone = ''.obs;
  final image = ''.obs;

  // =========================
  // APP
  // =========================

  final isDarkMode = false.obs;
  final isEnglish = true.obs;
  final primaryColorIndex = 0.obs;

  Color get primaryColor => AppColors.seedAt(primaryColorIndex.value);
  final isOnBoardingSeen = false.obs;
  final isRememberMe = false.obs;

  // =========================
  // STORAGE KEYS
  // =========================

  static const _tokenKey = 'token';
  static const _refreshTokenKey = 'refresh_token';
  static const _isLoggedInKey = 'is_logged_in';

  static const _userIdKey = 'user_id';
  static const _nameKey = 'name';
  static const _emailKey = 'email';
  static const _phoneKey = 'phone';
  static const _imageKey = 'image';

  static const _darkModeKey = 'dark_mode';
  static const _primaryColorKey = 'primary_color_index';
  static const _languageKey = 'language';
  static const _onBoardingKey = 'on_boarding';
  static const _rememberMeKey = 'remember_me';

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  // =========================
  // LOAD DATA
  // =========================

  void loadData() {
    token.value = _box.read(_tokenKey) ?? '';
    refreshToken.value = _box.read(_refreshTokenKey) ?? '';
    isLoggedIn.value = _box.read(_isLoggedInKey) ?? false;

    userId.value = _box.read(_userIdKey) ?? '';
    name.value = _box.read(_nameKey) ?? '';
    email.value = _box.read(_emailKey) ?? '';
    phone.value = _box.read(_phoneKey) ?? '';
    image.value = _box.read(_imageKey) ?? '';

    isDarkMode.value = _box.read(_darkModeKey) ?? false;
    primaryColorIndex.value = _box.read(_primaryColorKey) ?? 0;
    isEnglish.value = _box.read(_languageKey) ?? true;
    isOnBoardingSeen.value = _box.read(_onBoardingKey) ?? false;
    isRememberMe.value = _box.read(_rememberMeKey) ?? false;
  }

  // =========================
  // TOKEN
  // =========================

  Future<void> saveToken(String value) async {
    token.value = value;
    isLoggedIn.value = true;

    await _box.write(_tokenKey, value);
    await _box.write(_isLoggedInKey, true);
  }

  Future<void> saveRefreshToken(String value) async {
    refreshToken.value = value;
    await _box.write(_refreshTokenKey, value);
  }

  // =========================
  // USER
  // =========================

  Future<void> saveUser({
    required String id,
    required String fullName,
    required String userEmail,
    required String userPhone,
    String userImage = '',
  }) async {

    userId.value = id;
    name.value = fullName;
    email.value = userEmail;
    phone.value = userPhone;
    image.value = userImage;

    await _box.write(_userIdKey, id);
    await _box.write(_nameKey, fullName);
    await _box.write(_emailKey, userEmail);
    await _box.write(_phoneKey, userPhone);
    await _box.write(_imageKey, userImage);
  }

  // =========================
  // LANGUAGE
  // =========================

  Future<void> toggleLanguage() async {

    isEnglish.value = !isEnglish.value;

    await _box.write(
      _languageKey,
      isEnglish.value,
    );

    if (isEnglish.value) {
      Get.updateLocale(
        const Locale('en', 'US'),
      );
    } else {
      Get.updateLocale(
        const Locale('bn', 'BD'),
      );
    }
  }

  // =========================
  // THEME
  // =========================

  Future<void> toggleTheme() async {
    isDarkMode.value = !isDarkMode.value;
    await _box.write(_darkModeKey, isDarkMode.value);
    Get.changeThemeMode(
      isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
    );
  }

  Future<void> setPrimaryColorIndex(int index) async {
    primaryColorIndex.value = index % AppColors.seeds.length;
    await _box.write(_primaryColorKey, primaryColorIndex.value);
    Get.forceAppUpdate();
  }

  // =========================
  // ONBOARDING
  // =========================

  Future<void> setOnBoardingSeen() async {

    isOnBoardingSeen.value = true;

    await _box.write(
      _onBoardingKey,
      true,
    );
  }

  // =========================
  // REMEMBER ME
  // =========================

  Future<void> setRememberMe(bool value) async {

    isRememberMe.value = value;

    await _box.write(
      _rememberMeKey,
      value,
    );
  }

  // =========================
  // LOGOUT
  // =========================

  Future<void> logout() async {

    token.value = '';
    refreshToken.value = '';
    isLoggedIn.value = false;

    await _box.remove(_tokenKey);
    await _box.remove(_refreshTokenKey);
    await _box.write(_isLoggedInKey, false);
  }

  // =========================
  // CLEAR ALL
  // =========================

  Future<void> clearAll() async {

    await _box.erase();

    loadData();
  }
}