import 'package:flutter_core/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_core/features/posts/domain/repositories/i_post_repository.dart';
import 'package:flutter_core/features/posts/domain/usecases/create_post_usecase.dart';
import 'package:flutter_core/features/posts/domain/usecases/get_post_detail_usecase.dart';
import 'package:flutter_core/features/posts/domain/usecases/get_posts_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

class MockPostRepository implements IPostRepository {
  final List<PostEntity> _posts = [
    const PostEntity(
      id: 1,
      userId: 1,
      title: 'First Architecture Post',
      body: 'Clean architecture separating concerns cleanly.',
    ),
    const PostEntity(
      id: 2,
      userId: 1,
      title: 'Second Post',
      body: 'GetX state management with reactive observables.',
    ),
  ];

  @override
  Future<List<PostEntity>> getPosts() async {
    return _posts;
  }

  @override
  Future<PostEntity> getPostDetail(int id) async {
    final match = _posts.firstWhere(
      (p) => p.id == id,
      orElse: () => throw Exception('Post not found'),
    );
    return match;
  }

  @override
  Future<PostEntity> createPost({
    required String title,
    required String body,
    int userId = 1,
  }) async {
    final created = PostEntity(
      id: _posts.length + 1,
      userId: userId,
      title: title,
      body: body,
    );
    _posts.insert(0, created);
    return created;
  }
}

void main() {
  late MockPostRepository repository;
  late GetPostsUseCase getPostsUseCase;
  late GetPostDetailUseCase getPostDetailUseCase;
  late CreatePostUseCase createPostUseCase;

  setUp(() {
    repository = MockPostRepository();
    getPostsUseCase = GetPostsUseCase(repository);
    getPostDetailUseCase = GetPostDetailUseCase(repository);
    createPostUseCase = CreatePostUseCase(repository);
  });

  group('Post UseCases Unit Tests', () {
    test('GetPostsUseCase returns list of PostEntity', () async {
      final posts = await getPostsUseCase();
      expect(posts, isNotEmpty);
      expect(posts.length, 2);
      expect(posts.first.title, 'First Architecture Post');
    });

    test('GetPostDetailUseCase returns matching post by ID', () async {
      final post = await getPostDetailUseCase(1);
      expect(post.id, 1);
      expect(post.title, 'First Architecture Post');
      expect(post.body, contains('Clean architecture'));
    });

    test('GetPostDetailUseCase throws if post not found', () async {
      expect(
        () => getPostDetailUseCase(999),
        throwsA(isA<Exception>()),
      );
    });

    test('CreatePostUseCase creates and returns new PostEntity with valid input', () async {
      final newPost = await createPostUseCase(
        title: 'New Created Post',
        body: 'Post body content with sufficient length.',
      );

      expect(newPost.id, 3);
      expect(newPost.title, 'New Created Post');
      expect(newPost.body, 'Post body content with sufficient length.');

      final allPosts = await getPostsUseCase();
      expect(allPosts.length, 3);
      expect(allPosts.first.title, 'New Created Post');
    });

    test('CreatePostUseCase throws ArgumentError when title is blank', () async {
      expect(
        () => createPostUseCase(
          title: '   ',
          body: 'Valid body',
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('CreatePostUseCase throws ArgumentError when body is blank', () async {
      expect(
        () => createPostUseCase(
          title: 'Valid title',
          body: '',
        ),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
