import 'package:flutter_core/features/auth/bindings/auth_binding.dart';
import 'package:flutter_core/features/auth/screens/login_screen.dart';
import 'package:flutter_core/features/auth/screens/otp_screen.dart';
import 'package:flutter_core/features/auth/screens/register_screen.dart';
import 'package:flutter_core/features/common/screens/empty_demo_screen.dart';
import 'package:flutter_core/features/common/screens/network_error_screen.dart';
import 'package:flutter_core/features/common/screens/webview_screen.dart';
import 'package:flutter_core/features/posts/bindings/post_binding.dart';
import 'package:flutter_core/features/posts/screens/post_detail_screen.dart';
import 'package:flutter_core/features/posts/screens/post_list_screen.dart';
import 'package:flutter_core/features/showcase/bindings/showcase_binding.dart';
import 'package:flutter_core/features/showcase/screens/api_demo_screen.dart';
import 'package:flutter_core/features/showcase/screens/download_demo_screen.dart';
import 'package:flutter_core/features/showcase/screens/showcase_screen.dart';
import 'package:flutter_core/features/showcase/screens/theme_demo_screen.dart';
import 'package:flutter_core/features/showcase/screens/widget_demo_screen.dart';
import 'package:flutter_core/features/splash/bindings/splash_binding.dart';
import 'package:flutter_core/features/splash/screens/splash_screen.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: AppRoutes.initial,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.showcase,
      page: () => const ShowcaseScreen(),
      binding: ShowcaseBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => const OtpScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.widgetDemo,
      page: () => const WidgetDemoScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.apiDemo,
      page: () => const ApiDemoScreen(),
      binding: ShowcaseBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.themeDemo,
      page: () => const ThemeDemoScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.downloadDemo,
      page: () => const DownloadDemoScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.webview,
      page: () => const WebViewScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.noInternet,
      page: () => const NetworkErrorScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.emptyDemo,
      page: () => const EmptyDemoScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.posts,
      page: () => const PostListScreen(),
      binding: PostBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.postDetail,
      page: () => const PostDetailScreen(),
      transition: Transition.cupertino,
    ),
  ];
}
