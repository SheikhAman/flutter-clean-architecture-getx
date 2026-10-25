import 'package:dio/dio.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }

  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.get(url, queryParameters: queryParameters);
    if (response.data is Map<String, dynamic>) {
      return response.data as Map<String, dynamic>;
    }
    return {'data': response.data};
  }

  Future<Map<String, dynamic>> post(
    String url, {
    dynamic data,
  }) async {
    final response = await _dio.post(url, data: data);
    if (response.data is Map<String, dynamic>) {
      return response.data as Map<String, dynamic>;
    }
    return {'data': response.data};
  }

  Future<Map<String, dynamic>> put(
    String url, {
    dynamic data,
  }) async {
    final response = await _dio.put(url, data: data);
    if (response.data is Map<String, dynamic>) {
      return response.data as Map<String, dynamic>;
    }
    return {'data': response.data};
  }

  Future<Map<String, dynamic>> postMultipart(
    String url, {
    required Map<String, String> fields,
    required Map<String, String> fileFields,
  }) async {
    final formDataMap = <String, dynamic>{...fields};
    for (var entry in fileFields.entries) {
      formDataMap[entry.key] = MultipartFile.fromString(entry.value);
    }
    final formData = FormData.fromMap(formDataMap);
    final response = await _dio.post(url, data: formData);
    if (response.data is Map<String, dynamic>) {
      return response.data as Map<String, dynamic>;
    }
    return {'data': response.data};
  }
}
