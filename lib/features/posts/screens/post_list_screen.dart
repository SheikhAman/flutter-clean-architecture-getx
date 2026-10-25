import 'package:flutter/material.dart';
import 'package:flutter_core/core/widgets/app_button.dart';
import 'package:flutter_core/core/widgets/app_empty_state.dart';
import 'package:flutter_core/core/widgets/app_loader_button.dart';
import 'package:flutter_core/core/widgets/app_text_field.dart';
import 'package:flutter_core/features/posts/controllers/post_controller.dart';
import 'package:flutter_core/features/posts/widgets/post_card.dart';
import 'package:flutter_core/routes/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PostListScreen extends GetView<PostController> {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Refresh Posts',
            onPressed: controller.fetchPosts,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreatePostSheet(context),
        icon: const Icon(Icons.add),
        label: const Text('New Post'),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value && controller.posts.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (controller.errorMessage.value.isNotEmpty && controller.posts.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error_outline, size: 48.w, color: colorScheme.error),
                    SizedBox(height: 12.h),
                    Text(
                      'Failed to load posts',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      controller.errorMessage.value,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: 18.h),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 160.w),
                      child: AppButton(
                        text: 'Retry',
                        onTap: controller.fetchPosts,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (controller.posts.isEmpty) {
            return AppEmptyState(
              icon: Icons.article_outlined,
              title: 'No Posts Available',
              message: 'Be the first to publish a clean architecture post.',
              actionText: 'Create First Post',
              onAction: () => _showCreatePostSheet(context),
            );
          }

          return RefreshIndicator(
            onRefresh: controller.fetchPosts,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              itemCount: controller.posts.length,
              separatorBuilder: (_, __) => SizedBox(height: 10.h),
              itemBuilder: (context, index) {
                final post = controller.posts[index];
                return PostCard(
                  post: post,
                  onTap: () {
                    controller.selectedPost.value = post;
                    Get.toNamed(AppRoutes.postDetail, arguments: post);
                  },
                );
              },
            ),
          );
        }),
      ),
    );
  }

  void _showCreatePostSheet(BuildContext context) {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (bottomSheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 20.h,
            bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom + 20.h,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 36.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                Text(
                  'Create New Post',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 14.h),
                AppTextField(
                  controller: titleController,
                  label: 'Post Title',
                  prefixIcon: Icons.title,
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: bodyController,
                  label: 'Post Content',
                  prefixIcon: Icons.description_outlined,
                  maxLines: 4,
                ),
                SizedBox(height: 20.h),
                Obx(
                  () => AppLoaderButton(
                    label: 'Publish Post',
                    isLoading: controller.isCreating.value,
                    icon: Icons.send_rounded,
                    onPressed: () async {
                      final success = await controller.createNewPost(
                        title: titleController.text,
                        body: bodyController.text,
                      );
                      if (success) {
                        Get.back();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
