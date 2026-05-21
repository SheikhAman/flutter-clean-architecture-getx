import 'package:flutter_core/core/services/device_info_service.dart';
import 'package:flutter_core/network/api_service.dart';
import '../models/user_model.dart';

class AuthRepository {
  final ApiService apiService;
  final DeviceInfoService deviceInfo;

  AuthRepository({
    required this.apiService,
    required this.deviceInfo,
  });

  /// Demo login — hits JSONPlaceholder POST and attaches device payload.
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final device = await deviceInfo.getDevicePayload();

    final response = await apiService.createPost({
      'email': email,
      'password': password,
      'action': 'login',
      'device': device,
    });

    return UserModel.fromJson({
      'id': response['id']?.toString() ?? '1',
      'name': email.split('@').first,
      'email': email,
      'phone': device['model'] ?? '',
    });
  }

  Future<UserModel> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final device = await deviceInfo.getDevicePayload();

    final response = await apiService.createPost({
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'action': 'register',
      'device': device,
    });

    return UserModel.fromJson({
      'id': response['id']?.toString() ?? '1',
      'name': name,
      'email': email,
      'phone': phone,
    });
  }
}
