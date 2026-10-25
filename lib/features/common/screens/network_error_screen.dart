import 'package:flutter/material.dart';
import 'package:flutter_core/core/utils/app_toast.dart';
import 'package:flutter_core/core/widgets/app_loader_button.dart';
import 'package:flutter_core/network/internet_checker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NetworkErrorScreen extends StatefulWidget {
  final VoidCallback? onRetry;

  const NetworkErrorScreen({
    super.key,
    this.onRetry,
  });

  @override
  State<NetworkErrorScreen> createState() => _NetworkErrorScreenState();
}

class _NetworkErrorScreenState extends State<NetworkErrorScreen> {
  final RxBool _isChecking = false.obs;

  Future<void> _checkConnectivity() async {
    _isChecking.value = true;
    try {
      final isOnline = await InternetChecker.hasInternet();
      if (isOnline) {
        AppToast.success('Connection restored!');
        if (widget.onRetry != null) {
          widget.onRetry!();
        } else if (mounted && Navigator.canPop(context)) {
          Get.back();
        }
      } else {
        AppToast.error('Still offline. Please verify your Wi-Fi or cellular connection.');
      }
    } catch (_) {
      AppToast.error('Network check failed. Please check connectivity manually.');
    } finally {
      _isChecking.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Error'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 90.w,
                  height: 90.w,
                  decoration: BoxDecoration(
                    color: colorScheme.errorContainer.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.wifi_off_rounded,
                    size: 44.w,
                    color: colorScheme.error,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'No Internet Connection',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Unable to connect to the server. Please verify your Wi-Fi or cellular network and try again.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 28.h),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 240.w),
                  child: Obx(
                    () => AppLoaderButton(
                      label: 'Check & Retry Connection',
                      isLoading: _isChecking.value,
                      icon: Icons.refresh_rounded,
                      onPressed: _checkConnectivity,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                TextButton.icon(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back, size: 16),
                  label: const Text('Return to Showcase Hub'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
