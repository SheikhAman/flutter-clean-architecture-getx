import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class CacheService {

  static Future<File> getFile(
      String fileName,
      ) async {

    final dir =
    await getApplicationDocumentsDirectory();

    return File('${dir.path}/$fileName');
  }

  static Future<void> saveJsonFile({
    required String fileName,
    required dynamic data,
  }) async {

    final file = await getFile(fileName);

    final jsonString = jsonEncode(data);

    await file.writeAsString(jsonString);
  }

  static Future<dynamic> readJsonFile(
      String fileName,
      ) async {

    final file = await getFile(fileName);

    if (!file.existsSync()) {
      return null;
    }

    final jsonString =
    await file.readAsString();

    return jsonDecode(jsonString);
  }

  static Future<void> deleteFile(
      String fileName,
      ) async {

    final file = await getFile(fileName);

    if (file.existsSync()) {
      await file.delete();
    }
  }

  static Future<T> computeJson<T>({
    required String jsonString,
    required Future<T> Function(String data)
    parser,
  }) async {

    return await compute(
      parser,
      jsonString,
    );
  }
}