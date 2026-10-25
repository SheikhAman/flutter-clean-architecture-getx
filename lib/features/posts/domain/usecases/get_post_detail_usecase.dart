import '../entities/post_entity.dart';
import '../repositories/i_post_repository.dart';

class GetPostDetailUseCase {
  final IPostRepository repository;

  GetPostDetailUseCase(this.repository);

  Future<PostEntity> call(int id) {
    return repository.getPostDetail(id);
  }
}
