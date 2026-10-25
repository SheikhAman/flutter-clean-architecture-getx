import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_core/core/utils/app_toast.dart';
import 'package:flutter_core/network/api_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ApiDemoScreen extends StatefulWidget {
  const ApiDemoScreen({super.key});

  @override
  State<ApiDemoScreen> createState() => _ApiDemoScreenState();
}

class _ApiDemoScreenState extends State<ApiDemoScreen> {
  final ApiService _apiService = Get.find<ApiService>();

  final RxBool _isLoading = false.obs;
  final RxString _activeMethod = ''.obs;
  final RxString _responseOutput = 'Tap any button above to execute a real Dio network call.'.obs;
  final RxString _statusCode = ''.obs;

  Future<void> _executeCall(String method, Future<Map<String, dynamic>> Function() call) async {
    try {
      _isLoading.value = true;
      _activeMethod.value = method;
      _responseOutput.value = 'Sending $method request...';
      _statusCode.value = '';

      final stopwatch = Stopwatch()..start();
      final result = await call();
      stopwatch.stop();

      const encoder = JsonEncoder.withIndent('  ');
      final formattedJson = encoder.convert(result);

      _statusCode.value = '200 OK (${stopwatch.elapsedMilliseconds}ms)';
      _responseOutput.value = formattedJson;
      AppToast.success('$method call completed');
    } catch (e) {
      _statusCode.value = 'ERROR';
      _responseOutput.value = 'Request Failed:\n$e';
      AppToast.error('$method call failed: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('API & Networking Demo'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Execute Dio REST Endpoints',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'Uses public endpoints (JSONPlaceholder & Httpbin) with automatic logging interceptors.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 14.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  ElevatedButton.icon(
                    onPressed: _isLoading.value
                        ? null
                        : () => _executeCall('GET', () => _apiService.fetchPost()),
                    icon: const Icon(Icons.arrow_downward, color: Colors.blue),
                    label: const Text('GET Post #1'),
                  ),
                  ElevatedButton.icon(
                    onPressed: _isLoading.value
                        ? null
                        : () => _executeCall(
                              'POST',
                              () => _apiService.createPost({
                                'title': 'Clean Architecture Demo',
                                'body': 'Post body created via DioClient',
                                'userId': 1,
                              }),
                            ),
                    icon: const Icon(Icons.arrow_upward, color: Colors.green),
                    label: const Text('POST Create'),
                  ),
                  ElevatedButton.icon(
                    onPressed: _isLoading.value
                        ? null
                        : () => _executeCall(
                              'PUT',
                              () => _apiService.updatePost(
                                1,
                                {
                                  'id': 1,
                                  'title': 'Updated Title via Dio',
                                  'body': 'Updated Body text',
                                  'userId': 1,
                                },
                              ),
                            ),
                    icon: const Icon(Icons.refresh, color: Colors.orange),
                    label: const Text('PUT Update'),
                  ),
                  ElevatedButton.icon(
                    onPressed: _isLoading.value
                        ? null
                        : () => _executeCall(
                              'MULTIPART',
                              () => _apiService.uploadMultipartDemo(
                                note: 'Flutter Core Dio Upload Demo',
                              ),
                            ),
                    icon: const Icon(Icons.upload_file, color: Colors.purple),
                    label: const Text('Multipart Upload'),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Live Response Payload',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Obx(
                    () => _statusCode.value.isNotEmpty
                        ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: _statusCode.value.contains('ERROR')
                                  ? colorScheme.errorContainer
                                  : colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              _statusCode.value,
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                                color: _statusCode.value.contains('ERROR')
                                    ? colorScheme.onErrorContainer
                                    : colorScheme.onPrimaryContainer,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: theme.brightness == Brightness.dark
                        ? Colors.black.withValues(alpha: 0.5)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Obx(
                    () => _isLoading.value
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const CircularProgressIndicator(),
                                SizedBox(height: 12.h),
                                Text(
                                  'Executing ${_activeMethod.value}...',
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                              ],
                            ),
                          )
                        : SingleChildScrollView(
                            child: SelectableText(
                              _responseOutput.value,
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 12.sp,
                                height: 1.4,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
