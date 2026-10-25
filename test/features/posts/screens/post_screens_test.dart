import 'package:flutter/material.dart';
import 'package:flutter_core/features/posts/controllers/post_controller.dart';
import 'package:flutter_core/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_core/features/posts/domain/repositories/i_post_repository.dart';
import 'package:flutter_core/features/posts/domain/usecases/create_post_usecase.dart';
import 'package:flutter_core/features/posts/domain/usecases/get_post_detail_usecase.dart';
import 'package:flutter_core/features/posts/domain/usecases/get_posts_usecase.dart';
import 'package:flutter_core/features/posts/screens/post_detail_screen.dart';
import 'package:flutter_core/features/posts/screens/post_list_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

class FakePostRepository implements IPostRepository {
  final List<PostEntity> _posts;

  FakePostRepository([List<PostEntity>? initial])
      : _posts = initial ??
            [
              const PostEntity(
                id: 1,
                userId: 1,
                title: 'Clean Architecture in Flutter',
                body: 'Detailed article on Clean Architecture and GetX.',
              ),
              const PostEntity(
                id: 2,
                userId: 2,
                title: 'State Management Overview',
                body: 'How GetX reduces boilerplate without losing testability.',
              ),
            ];

  @override
  Future<List<PostEntity>> getPosts() async => _posts;

  @override
  Future<PostEntity> getPostDetail(int id) async =>
      _posts.firstWhere((p) => p.id == id);

  @override
  Future<PostEntity> createPost({
    required String title,
    required String body,
    int userId = 1,
  }) async {
    final post = PostEntity(
      id: _posts.length + 1,
      userId: userId,
      title: title,
      body: body,
    );
    _posts.insert(0, post);
    return post;
  }
}

Widget createTestApp(Widget child) {
  return ScreenUtilInit(
    designSize: const Size(360, 690),
    minTextAdapt: true,
    builder: (context, _) => GetMaterialApp(
      home: child,
    ),
  );
}

void main() {
  late FakePostRepository fakeRepository;
  late PostController postController;

  setUp(() {
    Get.reset();
    fakeRepository = FakePostRepository();
    postController = PostController(
      getPostsUseCase: GetPostsUseCase(fakeRepository),
      getPostDetailUseCase: GetPostDetailUseCase(fakeRepository),
      createPostUseCase: CreatePostUseCase(fakeRepository),
    );
    Get.put(postController);
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('PostListScreen renders posts and create post FAB', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(createTestApp(const PostListScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Posts Dashboard'), findsOneWidget);
    expect(find.text('New Post'), findsOneWidget);
    expect(find.text('Clean Architecture in Flutter'), findsOneWidget);
    expect(find.text('State Management Overview'), findsOneWidget);

    // Tap New Post FAB to verify bottom sheet opens
    await tester.tap(find.text('New Post'));
    await tester.pumpAndSettle();

    expect(find.text('Create New Post'), findsOneWidget);
    expect(find.text('Publish Post'), findsOneWidget);
  });

  testWidgets('PostDetailScreen renders post details passed via arguments', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    const samplePost = PostEntity(
      id: 42,
      userId: 7,
      title: 'Architectural Deep Dive',
      body: 'Full post content for unit testing presentation layer.',
    );

    postController.selectedPost.value = samplePost;

    await tester.pumpWidget(
      createTestApp(const PostDetailScreen()),
    );
    await tester.pumpAndSettle();

    expect(find.text('Post Detail'), findsOneWidget);
    expect(find.text('Post ID #42'), findsOneWidget);
    expect(find.text('Author ID: 7'), findsOneWidget);
    expect(find.text('Architectural Deep Dive'), findsOneWidget);
    expect(
      find.text('Full post content for unit testing presentation layer.'),
      findsOneWidget,
    );
  });
}
