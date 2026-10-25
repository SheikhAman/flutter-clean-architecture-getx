import '../entities/post_entity.dart';
import '../repositories/i_post_repository.dart';

class CreatePostUseCase {
  final IPostRepository repository;

  CreatePostUseCase(this.repository);

  Future<PostEntity> call({
    required String title,
    required String body,
    int userId = 1,
  }) {
    if (title.trim().isEmpty) {
      throw ArgumentError('Post title cannot be empty.');
    }
    if (body.trim().isEmpty) {
      throw ArgumentError('Post content cannot be empty.');
    }

    return repository.createPost(
      title: title.trim(),
      body: body.trim(),
      userId: userId,
    );
  }
}
