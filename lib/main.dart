import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'bindings/initial_binding.dart';
import 'core/storage/local_preferences.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'services/cache_service.dart';
import 'services/download_service.dart';
import 'services/language_service.dart';
import 'services/location_service.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  /// =========================
  /// LOCAL STORAGE
  /// =========================
  await LocalPreferences.init();

  /// =========================
  /// GLOBAL SERVICES
  /// =========================
  Get.put(LanguageService());
  Get.put(LocationService());
  Get.put(CacheService());
  Get.put(DownloadService());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final local = LocalPreferences.to;

    return ScreenUtilInit(

      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (context, child) {

        return Obx(() {

          return GetMaterialApp(

            title: "Flutter Core",

            debugShowCheckedModeBanner: false,

            /// =========================
            /// BINDING
            /// =========================
            initialBinding: InitialBinding(),

            /// =========================
            /// THEME
            /// =========================
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,

            themeMode: local.isDarkMode.value
                ? ThemeMode.dark
                : ThemeMode.light,

            /// =========================
            /// LANGUAGE
            /// =========================
            locale: local.isEnglish.value
                ? const Locale('en', 'US')
                : const Locale('bn', 'BD'),

            fallbackLocale: const Locale(
              'en',
              'US',
            ),

            /// =========================
            /// ROUTES
            /// =========================
            initialRoute: AppRoutes.initial,
            getPages: AppPages.routes,

          );
        });
      },
    );
  }
}