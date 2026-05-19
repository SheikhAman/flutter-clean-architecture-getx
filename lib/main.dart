import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_core/bindings/initial_binding.dart';
import 'package:flutter_core/core/services/cache_service.dart';
import 'package:flutter_core/core/services/download_service.dart';
import 'package:flutter_core/core/services/language_service.dart';
import 'package:flutter_core/core/services/location_service.dart';
import 'package:flutter_core/core/storage/local_preferences.dart';
import 'package:flutter_core/core/theme/app_theme.dart';
import 'package:flutter_core/routes/app_pages.dart';
import 'package:flutter_core/routes/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  /// =========================
  /// DEVICE ORIENTATION
  /// =========================
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  /// =========================
  /// STATUS BAR
  /// =========================
  SystemChrome.setSystemUIOverlayStyle(

    const SystemUiOverlayStyle(

      statusBarColor: Colors.transparent,

      statusBarIconBrightness:
      Brightness.dark,

      systemNavigationBarColor:
      Colors.white,

      systemNavigationBarIconBrightness:
      Brightness.dark,
    ),
  );

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

      useInheritedMediaQuery: true,

      builder: (context, child) {

        return Obx(() {

          return GetMaterialApp(

            /// =========================
            /// APP
            /// =========================
            title: "Flutter Core",

            debugShowCheckedModeBanner:
            false,

            defaultTransition:
            Transition.cupertino,

            transitionDuration:
            const Duration(
              milliseconds: 300,
            ),

            /// =========================
            /// INITIAL BINDING
            /// =========================
            initialBinding:
            InitialBinding(),

            /// =========================
            /// THEME
            /// =========================
            theme: AppTheme.light,

            darkTheme: AppTheme.dark,

            themeMode:
            local.isDarkMode.value
                ? ThemeMode.dark
                : ThemeMode.light,

            /// =========================
            /// LOCALIZATION
            /// =========================
            locale:
            local.isEnglish.value
                ? const Locale(
              'en',
              'US',
            )
                : const Locale(
              'bn',
              'BD',
            ),

            fallbackLocale:
            const Locale(
              'en',
              'US',
            ),

            /// =========================
            /// ROUTES
            /// =========================
            initialRoute:
            AppRoutes.initial,

            getPages:
            AppPages.routes,

            /// =========================
            /// KEYBOARD DISMISS
            /// =========================
            builder: (
                context,
                widget,
                ) {

              return GestureDetector(

                onTap: () {

                  FocusManager
                      .instance
                      .primaryFocus
                      ?.unfocus();
                },

                child:
                widget ??
                    const SizedBox(),
              );
            },
          );
        });
      },
    );
  }
}