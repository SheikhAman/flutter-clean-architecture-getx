import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_core/core/services/download_service.dart';
import 'package:flutter_core/core/utils/app_toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class DownloadDemoScreen extends StatefulWidget {
  const DownloadDemoScreen({super.key});

  @override
  State<DownloadDemoScreen> createState() => _DownloadDemoScreenState();
}

class _DownloadDemoScreenState extends State<DownloadDemoScreen> {
  final DownloadService _downloadService = Get.find<DownloadService>();

  final RxDouble _progress = 0.0.obs;
  final RxBool _isDownloading = false.obs;
  final RxString _downloadStatus = 'Ready to download'.obs;
  final RxString _savedPath = ''.obs;
  final RxInt _fileSizeBytes = 0.obs;

  static const String sampleUrl =
      'https://raw.githubusercontent.com/flutter/website/main/src/assets/images/shared/brand/flutter/logo/flutter-lockup.png';

  Future<void> _startDownload() async {
    try {
      _isDownloading.value = true;
      _progress.value = 0.0;
      _downloadStatus.value = 'Initializing download...';

      final tempDir = await getTemporaryDirectory();
      final targetPath = '${tempDir.path}/flutter_core_sample.png';

      await _downloadService.downloadFile(
        url: sampleUrl,
        savePath: targetPath,
        onProgress: (progress) {
          _progress.value = progress;
          _downloadStatus.value =
              'Downloading: ${(progress * 100).toStringAsFixed(1)}%';
        },
      );

      final file = File(targetPath);
      final exists = await file.exists();
      if (exists) {
        _savedPath.value = targetPath;
        _fileSizeBytes.value = await file.length();
        _downloadStatus.value = 'Download Completed Successfully!';
        AppToast.success('File downloaded');
      } else {
        _downloadStatus.value = 'File verification failed';
      }
    } catch (e) {
      _downloadStatus.value = 'Download Failed: $e';
      AppToast.error('Download error: $e');
    } finally {
      _isDownloading.value = false;
    }
  }

  Future<void> _deleteDownloadedFile() async {
    if (_savedPath.value.isNotEmpty) {
      await _downloadService.deleteFile(_savedPath.value);
      _savedPath.value = '';
      _fileSizeBytes.value = 0;
      _progress.value = 0.0;
      _downloadStatus.value = 'File removed from temporary storage';
      AppToast.info('Downloaded file deleted');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Download Service Demo'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Background File Downloader',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'Downloads files via Dio, tracking real-time progress callbacks and saving to device storage.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 16.h),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.insert_drive_file_outlined, size: 24.sp),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'flutter_core_sample.png',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  sampleUrl,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                      SizedBox(height: 16.h),
                      Obx(
                        () => LinearProgressIndicator(
                          value: _progress.value,
                          backgroundColor:
                              colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Text(
                              _downloadStatus.value,
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: colorScheme.primary,
                              ),
                            ),
                          ),
                          Obx(
                            () => Text(
                              '${(_progress.value * 100).toInt()}%',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Obx(
                () => ElevatedButton.icon(
                  onPressed: _isDownloading.value ? null : _startDownload,
                  icon: _isDownloading.value
                      ? SizedBox(
                          width: 18.w,
                          height: 18.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.download_rounded),
                  label: Text(_isDownloading.value
                      ? 'Downloading File...'
                      : 'Download Sample Asset'),
                ),
              ),
              SizedBox(height: 8.h),
              Obx(
                () => _savedPath.value.isNotEmpty
                    ? OutlinedButton.icon(
                        onPressed: _deleteDownloadedFile,
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        label: const Text('Delete Downloaded File'),
                      )
                    : const SizedBox.shrink(),
              ),
              SizedBox(height: 16.h),
              Obx(
                () => _savedPath.value.isNotEmpty
                    ? Card(
                        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
                        child: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'File Info:',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Path: ${_savedPath.value}',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontFamily: 'monospace',
                                ),
                              ),
                              Text(
                                'Size: ${_fileSizeBytes.value} bytes',
                                style: TextStyle(fontSize: 11.sp),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
