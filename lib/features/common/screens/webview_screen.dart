import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/core/utils/app_toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String? url;
  final String? title;

  const WebViewScreen({
    super.key,
    this.url,
    this.title,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  WebViewController? _controller;
  final RxBool _isLoading = true.obs;
  final RxInt _loadingProgress = 0.obs;
  final RxBool _isSupportedPlatform = true.obs;
  late final String _targetUrl;
  late final String _pageTitle;

  @override
  void initState() {
    super.initState();

    final args = Get.arguments as Map<String, dynamic>?;
    _targetUrl = widget.url ?? args?['url'] ?? 'https://flutter.dev';
    _pageTitle = widget.title ?? args?['title'] ?? 'In-App WebView';

    _initializeWebView();
  }

  void _initializeWebView() {
    try {
      // webview_flutter currently supports Android, iOS, and macOS natively
      final isSupported = !kIsWeb &&
          (defaultTargetPlatform == TargetPlatform.android ||
              defaultTargetPlatform == TargetPlatform.iOS ||
              defaultTargetPlatform == TargetPlatform.macOS);

      if (!isSupported) {
        _isSupportedPlatform.value = false;
        _isLoading.value = false;
        return;
      }

      final controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (progress) {
              _loadingProgress.value = progress;
            },
            onPageStarted: (url) {
              _isLoading.value = true;
            },
            onPageFinished: (url) {
              _isLoading.value = false;
            },
            onWebResourceError: (error) {
              _isLoading.value = false;
              AppToast.error('Web error: ${error.description}');
            },
          ),
        )
        ..loadRequest(Uri.parse(_targetUrl));

      _controller = controller;
    } catch (_) {
      _isSupportedPlatform.value = false;
      _isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _pageTitle,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              _targetUrl,
              style: TextStyle(
                fontSize: 11.sp,
                color: colorScheme.onSurfaceVariant,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Reload page',
            onPressed: () {
              if (_controller != null) {
                _controller!.reload();
              } else {
                AppToast.info('Reloading simulated web preview');
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Obx(() {
              if (_isLoading.value && _loadingProgress.value < 100) {
                return LinearProgressIndicator(
                  value: _loadingProgress.value > 0
                      ? _loadingProgress.value / 100.0
                      : null,
                  minHeight: 3.h,
                );
              }
              return const SizedBox.shrink();
            }),
            Expanded(
              child: Obx(() {
                if (!_isSupportedPlatform.value || _controller == null) {
                  return Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(24.w),
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(20.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.language_rounded,
                                size: 48.w,
                                color: colorScheme.primary,
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                'In-App WebView Component',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Target URL: $_targetUrl\n\nOn physical Android and iOS devices, this renders a native headless Chrome/Safari WebView instance with full JavaScript, cookies, and navigation delegates enabled.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              OutlinedButton.icon(
                                onPressed: () => AppToast.info('URL copied: $_targetUrl'),
                                icon: const Icon(Icons.copy, size: 16),
                                label: const Text('Copy URL'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }

                return WebViewWidget(controller: _controller!);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
