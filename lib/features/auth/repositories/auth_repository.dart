import '../models/user_model.dart';
import '../../../network/api_service.dart';

class AuthRepository {
  final ApiService apiService;

  AuthRepository(this.apiService);

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiService.login({
      "email": email,
      "password": password,
    });

    return UserModel.fromJson(response);
  }
}