import 'package:flutter_core/network/api_constants.dart';
import 'package:flutter_core/network/dio_client.dart';
import '../models/post_model.dart';

abstract class IPostRemoteDataSource {
  Future<List<PostModel>> getPosts();
  Future<PostModel> getPostDetail(int id);
  Future<PostModel> createPost({
    required String title,
    required String body,
    required int userId,
  });
}

class PostRemoteDataSource implements IPostRemoteDataSource {
  final DioClient client;

  PostRemoteDataSource(this.client);

  @override
  Future<List<PostModel>> getPosts() async {
    final response = await client.get('${ApiConstants.baseUrl}${ApiConstants.posts}');
    final dynamic rawData = response['data'] ?? response;

    if (rawData is List) {
      return rawData
          .map((item) => PostModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Future<PostModel> getPostDetail(int id) async {
    final response = await client.get('${ApiConstants.baseUrl}${ApiConstants.posts}/$id');
    final Map<String, dynamic> data = (response['data'] is Map<String, dynamic>)
        ? response['data'] as Map<String, dynamic>
        : response;

    return PostModel.fromJson(data);
  }

  @override
  Future<PostModel> createPost({
    required String title,
    required String body,
    required int userId,
  }) async {
    final response = await client.post(
      '${ApiConstants.baseUrl}${ApiConstants.posts}',
      data: {
        'title': title,
        'body': body,
        'userId': userId,
      },
    );

    final Map<String, dynamic> data = (response['data'] is Map<String, dynamic>)
        ? response['data'] as Map<String, dynamic>
        : response;

    return PostModel.fromJson(data);
  }
}
