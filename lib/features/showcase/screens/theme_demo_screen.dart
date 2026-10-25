import 'package:flutter/material.dart';
import 'package:flutter_core/core/storage/local_preferences.dart';
import 'package:flutter_core/core/theme/app_colors.dart';
import 'package:flutter_core/core/theme/theme_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ThemeDemoScreen extends StatelessWidget {
  const ThemeDemoScreen({super.key});

  static const List<String> seedNames = [
    'Deep Purple',
    'Royal Blue',
    'Teal Green',
    'Emerald',
    'Amber Orange',
    'Neon Pink',
  ];

  @override
  Widget build(BuildContext context) {
    final prefs = LocalPreferences.to;
    final themeController = Get.find<ThemeController>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme & Palette Demo'),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          children: [
            // Dark / Light Toggle Card
            Card(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Theme Mode',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Obx(
                            () => Text(
                              prefs.isDarkMode.value
                                  ? 'Dark Mode (Comfortable on eyes)'
                                  : 'Light Mode (Standard clean)',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => Switch(
                        value: prefs.isDarkMode.value,
                        onChanged: (val) => prefs.toggleTheme(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Material 3 Seed Palettes (6 Seeds)',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Obx(() {
              final selectedIndex = prefs.primaryColorIndex.value;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: AppColors.seeds.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  childAspectRatio: 2.4,
                ),
                itemBuilder: (context, index) {
                  final color = AppColors.seeds[index];
                  final isSelected = selectedIndex == index;

                  return InkWell(
                    onTap: () => themeController.setSeedIndex(index),
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isSelected ? color : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 28.w,
                            height: 28.w,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                            child: isSelected
                                ? const Icon(Icons.check, color: Colors.white, size: 16)
                                : null,
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              seedNames[index],
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
            SizedBox(height: 20.h),
            Text(
              'Live Themed Components Preview',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Themed Primary Button'),
                    ),
                    SizedBox(height: 10.h),
                    FilledButton.tonal(
                      onPressed: () {},
                      child: const Text('Themed Tonal Button'),
                    ),
                    SizedBox(height: 10.h),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('Themed Outlined Button'),
                    ),
                    SizedBox(height: 14.h),
                    Wrap(
                      spacing: 8.w,
                      children: [
                        Chip(
                          avatar: const Icon(Icons.palette, size: 16),
                          label: const Text('Dynamic Seed'),
                        ),
                        Chip(
                          avatar: const Icon(Icons.shield_outlined, size: 16),
                          label: const Text('Material 3'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
