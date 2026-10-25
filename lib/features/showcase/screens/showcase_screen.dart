import 'package:flutter/material.dart';
import 'package:flutter_core/core/storage/local_preferences.dart';
import 'package:flutter_core/core/theme/app_colors.dart';
import 'package:flutter_core/core/theme/theme_controller.dart';
import 'package:flutter_core/core/widgets/language_toggle.dart';
import 'package:flutter_core/routes/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ShowcaseScreen extends StatelessWidget {
  const ShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = LocalPreferences.to;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Flutter Core',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'GetX Clean Architecture Showcase',
              style: TextStyle(
                fontSize: 11.sp,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          const LanguageToggle(),
          Obx(
            () => IconButton(
              icon: Icon(
                prefs.isDarkMode.value
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
              ),
              tooltip: 'Toggle Theme',
              onPressed: () => prefs.toggleTheme(),
            ),
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          children: [
            _buildThemeSeedBar(context),
            SizedBox(height: 16.h),
            _buildSectionHeader(
              context,
              title: 'Component Showcase',
              subtitle: 'Core reusable modules and system demos',
              icon: Icons.layers_outlined,
            ),
            SizedBox(height: 8.h),
            _buildShowcaseCard(
              context,
              title: 'Widget Gallery',
              subtitle: 'Buttons, text fields, loaders, and language toggle',
              icon: Icons.widgets_outlined,
              badgeColor: Colors.blue,
              route: AppRoutes.widgetDemo,
            ),
            _buildShowcaseCard(
              context,
              title: 'API & Networking',
              subtitle: 'Dio GET, POST, PUT, and multipart with interceptors',
              icon: Icons.cloud_sync_outlined,
              badgeColor: Colors.green,
              route: AppRoutes.apiDemo,
            ),
            _buildShowcaseCard(
              context,
              title: 'Theme & Color Seeds',
              subtitle: 'Dynamic Material 3 theme generation across 6 seeds',
              icon: Icons.palette_outlined,
              badgeColor: Colors.purple,
              route: AppRoutes.themeDemo,
            ),
            _buildShowcaseCard(
              context,
              title: 'Download Service',
              subtitle: 'Background file download with progress tracking',
              icon: Icons.download_for_offline_outlined,
              badgeColor: Colors.teal,
              route: AppRoutes.downloadDemo,
            ),
            SizedBox(height: 16.h),
            _buildSectionHeader(
              context,
              title: 'Authentication Suite',
              subtitle: 'Auth screens with device metadata and demo OTP',
              icon: Icons.lock_outline,
            ),
            SizedBox(height: 8.h),
            _buildShowcaseCard(
              context,
              title: 'Login Screen',
              subtitle:
                  'Email & password validation with device metadata payload',
              icon: Icons.login_rounded,
              badgeColor: Colors.indigo,
              route: AppRoutes.login,
            ),
            _buildShowcaseCard(
              context,
              title: 'Register Screen',
              subtitle: 'Full registration form with field validations',
              icon: Icons.person_add_outlined,
              badgeColor: Colors.deepOrange,
              route: AppRoutes.register,
            ),
            _buildShowcaseCard(
              context,
              title: 'OTP Verification',
              subtitle: '6-digit pin code entry (Demo OTP: 112345)',
              icon: Icons.pin_outlined,
              badgeColor: Colors.amber.shade800,
              route: AppRoutes.otp,
            ),
            SizedBox(height: 16.h),
            _buildSectionHeader(
              context,
              title: 'App Utilities & States',
              subtitle: 'Fallbacks, error states, and embedded browser',
              icon: Icons.phonelink_setup_outlined,
            ),
            SizedBox(height: 8.h),
            _buildShowcaseCard(
              context,
              title: 'Empty State Demo',
              subtitle: 'User-friendly illustration for zero-content views',
              icon: Icons.inbox_outlined,
              badgeColor: Colors.grey.shade700,
              route: AppRoutes.emptyDemo,
            ),
            _buildShowcaseCard(
              context,
              title: 'Network Error Screen',
              subtitle: 'Offline connectivity detection and retry action',
              icon: Icons.wifi_off_outlined,
              badgeColor: Colors.red.shade700,
              route: AppRoutes.noInternet,
            ),
            _buildShowcaseCard(
              context,
              title: 'In-App WebView',
              subtitle: 'Embedded web browser for web pages and policies',
              icon: Icons.language_outlined,
              badgeColor: Colors.cyan.shade700,
              route: AppRoutes.webview,
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSeedBar(BuildContext context) {
    final prefs = LocalPreferences.to;
    final themeController = Get.find<ThemeController>();

    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.color_lens_outlined, size: 18.sp),
                      SizedBox(width: 8.w),
                      Flexible(
                        child: Text(
                          'Theme Seed Palette',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => Text(
                    prefs.isDarkMode.value ? 'Dark Mode' : 'Light Mode',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(AppColors.seeds.length, (index) {
                  final color = AppColors.seeds[index];
                  final isSelected = prefs.primaryColorIndex.value == index;

                  return GestureDetector(
                    onTap: () {
                      themeController.setSeedIndex(index);
                    },
                    child: Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(context).colorScheme.onSurface
                              : Colors.transparent,
                          width: 2.5,
                        ),
                        boxShadow: [
                          if (isSelected)
                            BoxShadow(
                              color: color.withValues(alpha: 0.4),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                        ],
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 18,
                            )
                          : null,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(left: 4.w, top: 4.h, bottom: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              size: 16.sp,
              color: colorScheme.primary,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.2,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShowcaseCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color badgeColor,
    required String route,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: EdgeInsets.only(bottom: 10.h),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Get.toNamed(route),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          child: Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: badgeColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  icon,
                  color: badgeColor,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: colorScheme.onSurfaceVariant,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: colorScheme.onSurfaceVariant,
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
