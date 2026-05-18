import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

class DownloadService extends GetxService {

  final Dio _dio = Dio();

  Future<void> downloadFile({
    required String url,
    required String savePath,
    Function(double progress)? onProgress,
  }) async {

    try {

      await _dio.download(
        url,
        savePath,

        onReceiveProgress: (
            received,
            total,
            ) {

          if (total != -1) {

            final progress =
                received / total;

            if (onProgress != null) {
              onProgress(progress);
            }
          }
        },
      );

    } on DioException catch (e) {

      throw Exception(
        e.message ??
            'Download failed',
      );
    } catch (e) {

      throw Exception(
        'Something went wrong',
      );
    }
  }

  Future<bool> fileExists(
      String path,
      ) async {

    return File(path).existsSync();
  }

  Future<void> deleteFile(
      String path,
      ) async {

    final file = File(path);

    if (file.existsSync()) {
      await file.delete();
    }
  }
}