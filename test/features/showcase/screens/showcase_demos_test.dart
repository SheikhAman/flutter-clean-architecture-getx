import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_core/core/services/download_service.dart';
import 'package:flutter_core/core/storage/local_preferences.dart';
import 'package:flutter_core/core/theme/theme_controller.dart';
import 'package:flutter_core/features/showcase/screens/api_demo_screen.dart';
import 'package:flutter_core/features/showcase/screens/download_demo_screen.dart';
import 'package:flutter_core/features/showcase/screens/theme_demo_screen.dart';
import 'package:flutter_core/features/showcase/screens/widget_demo_screen.dart';
import 'package:flutter_core/network/api_service.dart';
import 'package:flutter_core/network/dio_client.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Widget createTestApp(Widget child) {
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
    Get.put(DioClient());
    Get.put(ApiService(Get.find<DioClient>()));
    Get.put(DownloadService());
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('WidgetDemoScreen renders inputs, buttons, and toast actions', (tester) async {
    await tester.pumpWidget(createTestApp(const WidgetDemoScreen()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Widget Showcase'), findsOneWidget);
    expect(find.text('Standard AppButton'), findsOneWidget);
    expect(find.text('Tap to Trigger Loading'), findsOneWidget);
    expect(find.text('Success Toast'), findsOneWidget);
  });

  testWidgets('ApiDemoScreen renders REST endpoint action buttons', (tester) async {
    await tester.pumpWidget(createTestApp(const ApiDemoScreen()));
    await tester.pumpAndSettle();

    expect(find.text('API & Networking Demo'), findsOneWidget);
    expect(find.text('GET Post #1'), findsOneWidget);
    expect(find.text('POST Create'), findsOneWidget);
    expect(find.text('PUT Update'), findsOneWidget);
    expect(find.text('Multipart Upload'), findsOneWidget);
  });

  testWidgets('ThemeDemoScreen renders theme mode switch and all seed options', (tester) async {
    await tester.pumpWidget(createTestApp(const ThemeDemoScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Theme & Palette Demo'), findsOneWidget);
    expect(find.text('Theme Mode'), findsOneWidget);
    expect(find.text('Deep Purple'), findsOneWidget);
    expect(find.text('Royal Blue'), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();
    expect(find.text('Themed Primary Button'), findsOneWidget);
  });

  testWidgets('DownloadDemoScreen renders background downloader UI and action button', (tester) async {
    await tester.pumpWidget(createTestApp(const DownloadDemoScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Download Service Demo'), findsOneWidget);
    expect(find.text('Background File Downloader'), findsOneWidget);
    expect(find.text('Download Sample Asset'), findsOneWidget);
  });
}
