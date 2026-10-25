import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_core/core/constants/app_constants.dart';
import 'package:flutter_core/core/storage/local_preferences.dart';
import 'package:flutter_core/core/theme/theme_controller.dart';
import 'package:flutter_core/features/auth/controllers/auth_controller.dart';
import 'package:flutter_core/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_core/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:flutter_core/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_core/features/auth/domain/usecases/register_usecase.dart';
import 'package:flutter_core/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:flutter_core/features/auth/screens/login_screen.dart';
import 'package:flutter_core/features/auth/screens/otp_screen.dart';
import 'package:flutter_core/features/auth/screens/register_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FakeAuthRepo implements IAuthRepository {
  @override
  Future<UserEntity> login({required String email, required String password}) async {
    return UserEntity(id: '1', name: 'Tester', email: email, phone: '123456');
  }

  @override
  Future<UserEntity> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    return UserEntity(id: '2', name: name, email: email, phone: phone);
  }

  @override
  Future<bool> verifyOtp({required String code, String? email}) async {
    return code == AppConstants.demoOtp;
  }
}

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

    final repo = FakeAuthRepo();
    Get.put(
      AuthController(
        loginUseCase: LoginUseCase(repo),
        registerUseCase: RegisterUseCase(repo),
        verifyOtpUseCase: VerifyOtpUseCase(repo),
      ),
    );
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('LoginScreen renders email, password inputs, and login button', (tester) async {
    await tester.pumpWidget(createTestApp(LoginScreen()));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('demo@mail.com'), findsOneWidget);
  });

  testWidgets('RegisterScreen renders form fields and register button', (tester) async {
    await tester.pumpWidget(createTestApp(const RegisterScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Create an Account'), findsOneWidget);
    expect(find.text('Full Name'), findsOneWidget);
    expect(find.text('Confirm Password'), findsOneWidget);
  });

  testWidgets('OtpScreen renders pin input and demo OTP badge', (tester) async {
    await tester.pumpWidget(createTestApp(const OtpScreen()));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Enter Verification Code'), findsOneWidget);
    expect(find.textContaining('Demo OTP: 112345'), findsOneWidget);
    expect(find.text('Verify Code'), findsOneWidget);
  });
}
