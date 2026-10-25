import 'package:flutter_core/network/dio_client.dart';
import 'package:get/get.dart';
import '../controllers/post_controller.dart';
import '../data/datasources/post_remote_datasource.dart';
import '../data/repositories/post_repository_impl.dart';
import '../domain/repositories/i_post_repository.dart';
import '../domain/usecases/create_post_usecase.dart';
import '../domain/usecases/get_post_detail_usecase.dart';
import '../domain/usecases/get_posts_usecase.dart';

class PostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IPostRemoteDataSource>(
      () => PostRemoteDataSource(Get.find<DioClient>()),
    );
    Get.lazyPut<IPostRepository>(
      () => PostRepositoryImpl(Get.find<IPostRemoteDataSource>()),
    );
    Get.lazyPut(
      () => GetPostsUseCase(Get.find<IPostRepository>()),
    );
    Get.lazyPut(
      () => GetPostDetailUseCase(Get.find<IPostRepository>()),
    );
    Get.lazyPut(
      () => CreatePostUseCase(Get.find<IPostRepository>()),
    );
    Get.lazyPut(
      () => PostController(
        getPostsUseCase: Get.find<GetPostsUseCase>(),
        getPostDetailUseCase: Get.find<GetPostDetailUseCase>(),
        createPostUseCase: Get.find<CreatePostUseCase>(),
      ),
    );
  }
}
