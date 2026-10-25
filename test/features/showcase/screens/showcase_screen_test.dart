import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_core/core/storage/local_preferences.dart';
import 'package:flutter_core/core/theme/theme_controller.dart';
import 'package:flutter_core/features/common/screens/unknown_route_screen.dart';
import 'package:flutter_core/features/showcase/screens/showcase_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Widget createTestWidget(Widget child) {
  return ScreenUtilInit(
    designSize: const Size(360, 690),
    minTextAdapt: true,
    builder: (context, _) => GetMaterialApp(
      home: child,
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (MethodCall methodCall) async => '.',
    );
    await GetStorage.init();
  });

  setUp(() {
    Get.reset();
    Get.put(LocalPreferences());
    Get.put(ThemeController());
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('ShowcaseScreen renders hub title and demo cards',
      (tester) async {
    await tester.pumpWidget(createTestWidget(const ShowcaseScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Flutter Core'), findsOneWidget);
    expect(find.text('GetX Clean Architecture Showcase'), findsOneWidget);
    expect(find.text('Widget Gallery'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Theme & Color Seeds'), 100);
    expect(find.text('Theme & Color Seeds'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Login Screen'), 100);
    expect(find.text('Login Screen'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Empty State Demo'), 100);
    expect(find.text('Empty State Demo'), findsOneWidget);
  });

  testWidgets('UnknownRouteScreen renders 404 message and back button',
      (tester) async {
    await tester.pumpWidget(createTestWidget(const UnknownRouteScreen()));
    await tester.pumpAndSettle();

    expect(find.text('404 Not Found'), findsOneWidget);
    expect(find.text('Route Not Found'), findsOneWidget);
    expect(find.text('Back to Showcase'), findsOneWidget);
  });
}
