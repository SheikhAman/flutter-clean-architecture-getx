import 'package:flutter/material.dart';
import 'package:flutter_core/features/posts/controllers/post_controller.dart';
import 'package:flutter_core/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final controller = Get.find<PostController>();

    final PostEntity? initialPost = Get.arguments as PostEntity?;
    final post = initialPost ?? controller.selectedPost.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Detail'),
      ),
      body: SafeArea(
        child: post == null
            ? const Center(child: Text('No post selected.'))
            : SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 10.w,
                      runSpacing: 8.h,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            'Post ID #${post.id}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                        Chip(
                          avatar: const Icon(Icons.person_outline, size: 14),
                          label: Text('Author ID: ${post.userId}'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      post.title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Card(
                      elevation: 0,
                      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Text(
                          post.body,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontSize: 14.sp,
                            height: 1.6,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'Clean Architecture Highlights',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ListTile(
                      leading: Icon(Icons.layers, color: colorScheme.primary),
                      title: const Text('Pure Domain Entity'),
                      subtitle: const Text('PostEntity has zero JSON or Dio dependencies.'),
                      contentPadding: EdgeInsets.zero,
                    ),
                    ListTile(
                      leading: Icon(Icons.call_split, color: colorScheme.secondary),
                      title: const Text('Single Responsibility Use Case'),
                      subtitle: const Text('Retrieved via GetPostDetailUseCase through IPostRepository.'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
