import 'package:flutter_core/network/api_service.dart';
import 'package:flutter_core/network/dio_client.dart';
import 'package:get/get.dart';

class NetworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DioClient>(() => DioClient(), fenix: true);
    Get.lazyPut<ApiService>(() => ApiService(Get.find()), fenix: true);
  }
}
