import 'package:flutter_core/network/api_constants.dart';
import 'package:flutter_core/network/dio_client.dart';

class ApiService {
  final DioClient client;

  ApiService(this.client);

  Future<Map<String, dynamic>> fetchPost() {
    return client.get('${ApiConstants.baseUrl}${ApiConstants.postById}');
  }

  Future<Map<String, dynamic>> createPost(Map<String, dynamic> body) {
    return client.post(
      '${ApiConstants.baseUrl}${ApiConstants.posts}',
      data: body,
    );
  }

  Future<Map<String, dynamic>> updatePost(
    int id,
    Map<String, dynamic> body,
  ) {
    return client.put(
      '${ApiConstants.baseUrl}${ApiConstants.posts}/$id',
      data: body,
    );
  }

  Future<Map<String, dynamic>> uploadMultipartDemo({
    required String note,
  }) {
    return client.postMultipart(
      ApiConstants.multipartDemo,
      fields: {'note': note, 'source': 'flutter_core'},
      fileFields: {'demo_file': 'hello from flutter_core boilerplate'},
    );
  }
}
