import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/i_post_repository.dart';
import '../datasources/post_remote_datasource.dart';

class PostRepositoryImpl implements IPostRepository {
  final IPostRemoteDataSource remoteDataSource;

  PostRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<PostEntity>> getPosts() async {
    final models = await remoteDataSource.getPosts();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<PostEntity> getPostDetail(int id) async {
    final model = await remoteDataSource.getPostDetail(id);
    return model.toEntity();
  }

  @override
  Future<PostEntity> createPost({
    required String title,
    required String body,
    int userId = 1,
  }) async {
    final model = await remoteDataSource.createPost(
      title: title,
      body: body,
      userId: userId,
    );
    return model.toEntity();
  }
}
