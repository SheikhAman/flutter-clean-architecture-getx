import '../entities/post_entity.dart';
import '../repositories/i_post_repository.dart';

class GetPostsUseCase {
  final IPostRepository repository;

  GetPostsUseCase(this.repository);

  Future<List<PostEntity>> call() {
    return repository.getPosts();
  }
}
