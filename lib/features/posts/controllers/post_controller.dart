import 'package:flutter_core/core/utils/app_toast.dart';
import 'package:get/get.dart';
import '../domain/entities/post_entity.dart';
import '../domain/usecases/create_post_usecase.dart';
import '../domain/usecases/get_post_detail_usecase.dart';
import '../domain/usecases/get_posts_usecase.dart';

class PostController extends GetxController {
  final GetPostsUseCase getPostsUseCase;
  final GetPostDetailUseCase getPostDetailUseCase;
  final CreatePostUseCase createPostUseCase;

  PostController({
    required this.getPostsUseCase,
    required this.getPostDetailUseCase,
    required this.createPostUseCase,
  });

  final RxBool isLoading = false.obs;
  final RxBool isCreating = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<PostEntity> posts = <PostEntity>[].obs;
  final Rxn<PostEntity> selectedPost = Rxn<PostEntity>();

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await getPostsUseCase();
      posts.assignAll(result);
    } catch (e) {
      errorMessage.value = 'Failed to load posts: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadPostDetail(int id) async {
    isLoading.value = true;
    errorMessage.value = '';
    selectedPost.value = null;
    try {
      final post = await getPostDetailUseCase(id);
      selectedPost.value = post;
    } catch (e) {
      errorMessage.value = 'Failed to load post detail: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> createNewPost({
    required String title,
    required String body,
  }) async {
    isCreating.value = true;
    try {
      final newPost = await createPostUseCase(
        title: title,
        body: body,
      );
      posts.insert(0, newPost);
      AppToast.success('Post created successfully!');
      return true;
    } catch (e) {
      AppToast.error(e.toString());
      return false;
    } finally {
      isCreating.value = false;
    }
  }
}
