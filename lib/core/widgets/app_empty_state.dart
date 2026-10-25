import 'package:flutter/material.dart';
import 'package:flutter_core/core/widgets/app_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable clean empty state display component
class AppEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? actionText;
  final VoidCallback? onAction;

  const AppEmptyState({
    super.key,
    this.icon = Icons.inbox_outlined,
    required this.title,
    required this.message,
    this.actionText,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 40.w,
                color: colorScheme.primary,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontSize: 13.sp,
              ),
            ),
            if (actionText != null && onAction != null) ...[
              SizedBox(height: 24.h),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 220.w),
                child: AppButton(
                  text: actionText!,
                  onTap: onAction!,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
