import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'bindings/initial_binding.dart';

// https://chatgpt.com/c/6a098a8a-2cc0-83ec-b5eb-c4b71bba2bb4

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, _) =>  GetMaterialApp(
        title: "App Title",
        debugShowCheckedModeBanner: false,
        initialBinding: InitialBinding(),
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        initialRoute: AppRoutes.initial,
        getPages: AppPages.routes,
      ),
    );
  }
}