import 'package:flutter/material.dart';
import 'package:flutter_core/core/constants/app_constants.dart';
import 'package:flutter_core/core/widgets/app_loader_button.dart';
import 'package:flutter_core/features/auth/controllers/auth_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _pinController = TextEditingController();
  final AuthController _controller = Get.find<AuthController>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final email = Get.arguments is Map && Get.arguments['email'] != null
        ? Get.arguments['email'] as String
        : (_controller.pendingEmail.value.isNotEmpty
            ? _controller.pendingEmail.value
            : 'demo@fluttercore.dev');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 12.h),
              Container(
                width: 72.w,
                height: 72.w,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.mark_email_read_outlined,
                  size: 36.sp,
                  color: colorScheme.primary,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Enter Verification Code',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'We have sent a 6-digit code to\n$email',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 20.h),
              // Demo OTP Banner
              InkWell(
                onTap: () {
                  _pinController.text = AppConstants.demoOtp;
                },
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Colors.amber.shade700.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: Colors.amber.shade900,
                        size: 18.sp,
                      ),
                      SizedBox(width: 8.w),
                      Flexible(
                        child: Text(
                          'Demo OTP: ${AppConstants.demoOtp} (Tap to auto-fill)',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.amber.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              // 6-digit Pin Code Field
              PinCodeTextField(
                appContext: context,
                length: AppConstants.otpLength,
                controller: _pinController,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                cursorColor: colorScheme.primary,
                textStyle: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(12.r),
                  fieldHeight: 52.h,
                  fieldWidth: 44.w,
                  activeColor: colorScheme.primary,
                  selectedColor: colorScheme.primary,
                  inactiveColor: colorScheme.outlineVariant,
                  activeFillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
                  selectedFillColor: colorScheme.surface,
                  inactiveFillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.2),
                ),
                enableActiveFill: true,
                onChanged: (value) {
                  _controller.otpError.value = '';
                },
                onCompleted: (pin) {
                  _controller.verifyOtp(pin);
                },
              ),
              Obx(
                () => _controller.otpError.value.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Text(
                          _controller.otpError.value,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: colorScheme.error,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              SizedBox(height: 24.h),
              Obx(
                () => AppLoaderButton(
                  label: 'Verify Code',
                  isLoading: _controller.isOtpVerifying.value,
                  icon: Icons.verified_user_outlined,
                  onPressed: () {
                    final code = _pinController.text.trim();
                    if (code.length == AppConstants.otpLength) {
                      _controller.verifyOtp(code);
                    } else {
                      _controller.otpError.value =
                          'Please enter a valid 6-digit code';
                    }
                  },
                ),
              ),
              SizedBox(height: 20.h),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    'Didn\'t receive code? ',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  TextButton(
                    onPressed: () => _controller.resendOtp(),
                    child: Text(
                      'Resend',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
