import 'package:flutter/material.dart';
import 'package:flutter_core/core/widgets/app_empty_state.dart';
import 'package:flutter_core/features/common/screens/empty_demo_screen.dart';
import 'package:flutter_core/features/common/screens/network_error_screen.dart';
import 'package:flutter_core/features/common/screens/webview_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

Widget createTestApp(Widget child) {
  return ScreenUtilInit(
    designSize: const Size(360, 690),
    minTextAdapt: true,
    builder: (context, _) => GetMaterialApp(
      builder: EasyLoading.init(),
      home: child,
    ),
  );
}

void main() {
  setUp(() {
    Get.reset();
  });

  tearDown(() {
    EasyLoading.dismiss();
    Get.reset();
  });

  testWidgets('AppEmptyState renders title, message, and action button', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    bool actionTapped = false;
    await tester.pumpWidget(
      createTestApp(
        AppEmptyState(
          title: 'Empty Inbox',
          message: 'No messages received today.',
          actionText: 'Compose',
          onAction: () => actionTapped = true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Empty Inbox'), findsOneWidget);
    expect(find.text('No messages received today.'), findsOneWidget);
    expect(find.text('Compose'), findsOneWidget);

    await tester.tap(find.text('Compose'));
    await tester.pumpAndSettle();
    expect(actionTapped, isTrue);
  });

  testWidgets('EmptyDemoScreen toggles between empty state and populated list', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(createTestApp(const EmptyDemoScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Empty State Demo'), findsOneWidget);
    expect(find.text('No Data Records Found'), findsOneWidget);
    expect(find.text('Load Sample Records'), findsOneWidget);

    // Tap to populate using action button
    await tester.tap(find.text('Load Sample Records'));
    await tester.pumpAndSettle();

    expect(find.text('Clean Architecture Starter Item 1'), findsOneWidget);
    expect(find.text('No Data Records Found'), findsNothing);

    // Tap toggle in AppBar to clear and return to empty state
    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();

    expect(find.text('No Data Records Found'), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
  });

  testWidgets('NetworkErrorScreen renders offline warning and retry action', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      createTestApp(
        const NetworkErrorScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Network Error'), findsOneWidget);
    expect(find.text('No Internet Connection'), findsOneWidget);
    expect(find.text('Check & Retry Connection'), findsOneWidget);
    expect(find.text('Return to Showcase Hub'), findsOneWidget);
  });

  testWidgets('WebViewScreen renders title, URL, and reload button', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      createTestApp(
        const WebViewScreen(
          url: 'https://flutter.dev',
          title: 'Flutter Documentation',
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Flutter Documentation'), findsOneWidget);
    expect(find.text('https://flutter.dev'), findsOneWidget);
    expect(find.byIcon(Icons.refresh_rounded), findsOneWidget);
  });
}
