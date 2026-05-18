import 'api_client.dart';
import 'api_constants.dart';

class ApiService {
  final ApiClient apiClient;

  ApiService(this.apiClient);

  Future<dynamic> login(Map<String, dynamic> data) {
    return apiClient.post(ApiConstants.login, data);
  }

  Future<dynamic> register(Map<String, dynamic> data) {
    return apiClient.post(ApiConstants.register, data);
  }

  Future<dynamic> getUsers() {
    return apiClient.get(ApiConstants.users);
  }
}