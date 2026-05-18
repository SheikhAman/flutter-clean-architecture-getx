import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../network/api_client.dart';
import '../network/api_service.dart';

class NetworkBinding extends Bindings {
  @override
  void dependencies() {
    final client = http.Client();

    Get.put(ApiClient(client: client));
    Get.put(ApiService(Get.find<ApiClient>()));
  }
}