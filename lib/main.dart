import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_core/bindings/initial_binding.dart';
import 'package:flutter_core/core/services/cache_service.dart';
import 'package:flutter_core/core/services/device_info_service.dart';
import 'package:flutter_core/core/services/download_service.dart';
import 'package:flutter_core/core/services/language_service.dart';
import 'package:flutter_core/core/services/location_service.dart';
import 'package:flutter_core/core/storage/local_preferences.dart';
import 'package:flutter_core/core/theme/theme_controller.dart';
import 'package:flutter_core/languages/app_translations.dart';
import 'package:flutter_core/routes/app_pages.dart';
import 'package:flutter_core/routes/app_routes.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  await LocalPreferences.init();

  Get.put(DeviceInfoService(), permanent: true);
  Get.put(ThemeController(), permanent: true);
  Get.put(LanguageService());
  Get.put(LocationService());
  Get.put(CacheService());
  Get.put(DownloadService());

  _configEasyLoading();

  runApp(const MyApp());
}

void _configEasyLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(seconds: 2)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..radius = 12
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = LocalPreferences.to;
    final theme = Get.find<ThemeController>();

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Obx(
          () => GetMaterialApp(
            title: 'Flutter Core',
            debugShowCheckedModeBanner: false,
            translations: AppTranslations(),
            locale: prefs.isEnglish.value
                ? const Locale('en', 'US')
                : const Locale('bn', 'BD'),
            fallbackLocale: const Locale('en', 'US'),
            defaultTransition: Transition.cupertino,
            transitionDuration: const Duration(milliseconds: 300),
            initialBinding: InitialBinding(),
            theme: theme.lightTheme,
            darkTheme: theme.darkTheme,
            themeMode:
                prefs.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
            initialRoute: AppRoutes.initial,
            getPages: AppPages.routes,
            builder: EasyLoading.init(
              builder: (context, widget) {
                return GestureDetector(
                  onTap: () =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  child: widget ?? const SizedBox(),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
