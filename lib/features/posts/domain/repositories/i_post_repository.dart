import '../entities/post_entity.dart';

abstract class IPostRepository {
  Future<List<PostEntity>> getPosts();
  Future<PostEntity> getPostDetail(int id);
  Future<PostEntity> createPost({
    required String title,
    required String body,
    int userId = 1,
  });
}
