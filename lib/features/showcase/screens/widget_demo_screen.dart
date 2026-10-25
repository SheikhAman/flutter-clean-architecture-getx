import 'package:flutter/material.dart';
import 'package:flutter_core/core/utils/app_toast.dart';
import 'package:flutter_core/core/widgets/app_button.dart';
import 'package:flutter_core/core/widgets/app_loader_button.dart';
import 'package:flutter_core/core/widgets/app_text_field.dart';
import 'package:flutter_core/core/widgets/language_toggle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class WidgetDemoScreen extends StatefulWidget {
  const WidgetDemoScreen({super.key});

  @override
  State<WidgetDemoScreen> createState() => _WidgetDemoScreenState();
}

class _WidgetDemoScreenState extends State<WidgetDemoScreen> {
  final _demoTextController = TextEditingController(text: 'Sample input value');
  final _passwordController = TextEditingController(text: 'secret123');
  final RxBool _isBtnLoading = false.obs;

  @override
  void dispose() {
    _demoTextController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Showcase'),
        actions: const [
          LanguageToggle(),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          children: [
            _buildSection(
              title: 'Form Inputs (AppTextField)',
              child: Column(
                children: [
                  AppTextField(
                    controller: _demoTextController,
                    label: 'Standard Input',
                    prefixIcon: Icons.edit_outlined,
                  ),
                  SizedBox(height: 12.h),
                  AppTextField(
                    controller: _passwordController,
                    label: 'Password Input (Obscured)',
                    prefixIcon: Icons.lock_outline,
                    obscure: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 18.h),
            _buildSection(
              title: 'Action Buttons (AppButton & AppLoaderButton)',
              child: Column(
                children: [
                  AppButton(
                    text: 'Standard AppButton',
                    onTap: () => AppToast.info('AppButton tapped!'),
                  ),
                  SizedBox(height: 12.h),
                  Obx(
                    () => AppLoaderButton(
                      label: _isBtnLoading.value
                          ? 'Processing Request...'
                          : 'Tap to Trigger Loading',
                      isLoading: _isBtnLoading.value,
                      icon: Icons.flash_on_rounded,
                      onPressed: () async {
                        _isBtnLoading.value = true;
                        await Future.delayed(const Duration(seconds: 2));
                        _isBtnLoading.value = false;
                        AppToast.success('Action Completed!');
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18.h),
            _buildSection(
              title: 'Toast & Feedback Dialogs',
              child: Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => AppToast.success('Operation succeeded!'),
                    icon: const Icon(Icons.check_circle_outline, color: Colors.green),
                    label: const Text('Success Toast'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => AppToast.error('Something went wrong!'),
                    icon: const Icon(Icons.error_outline, color: Colors.red),
                    label: const Text('Error Toast'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => AppToast.info('Here is a helpful tip.'),
                    icon: const Icon(Icons.info_outline, color: Colors.blue),
                    label: const Text('Info Toast'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _showDemoBottomSheet(context),
                    icon: const Icon(Icons.vertical_align_bottom_rounded),
                    label: const Text('Modal BottomSheet'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18.h),
            _buildSection(
              title: 'Shimmer Loading Placeholders',
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Shimmer.fromColors(
                    baseColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                    highlightColor: colorScheme.surface,
                    child: Row(
                      children: [
                        Container(
                          width: 48.w,
                          height: 48.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 14.h,
                                color: Colors.white,
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                width: 140.w,
                                height: 10.h,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        child,
      ],
    );
  }

  void _showDemoBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Reusable BottomSheet Demo',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              Text(
                'This bottom sheet conforms to your active Material 3 theme.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.sp),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close Sheet'),
              ),
            ],
          ),
        );
      },
    );
  }
}
