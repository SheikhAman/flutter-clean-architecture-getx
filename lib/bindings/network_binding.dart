import 'package:flutter_core/network/api_client.dart';
import 'package:flutter_core/network/api_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NetworkBinding extends Bindings {
  @override
  void dependencies() {
    /// =========================
    /// HTTP CLIENT
    /// =========================
    Get.lazyPut<http.Client>(
      () => http.Client(),
      fenix: true,
    );

    /// =========================
    /// API CLIENT
    /// =========================
    Get.lazyPut<ApiClient>(
      () => ApiClient(
        client: Get.find(),
      ),
      fenix: true,
    );

    /// =========================
    /// API SERVICE
    /// =========================
    Get.lazyPut<ApiService>(
      () => ApiService(
        Get.find<ApiClient>(),
      ),
      fenix: true,
    );
  }
}
