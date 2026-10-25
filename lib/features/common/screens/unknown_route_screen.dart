import 'package:flutter/material.dart';
import 'package:flutter_core/routes/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UnknownRouteScreen extends StatelessWidget {
  const UnknownRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routeName = Get.currentRoute;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('404 Not Found'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 72.sp,
                  color: theme.colorScheme.error,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Route Not Found',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'No destination found for route: $routeName',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 24.h),
                ElevatedButton.icon(
                  onPressed: () => Get.offAllNamed(AppRoutes.showcase),
                  icon: const Icon(Icons.home_rounded),
                  label: const Text('Back to Showcase'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
