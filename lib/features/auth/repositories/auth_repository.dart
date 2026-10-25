import 'package:flutter_core/core/constants/app_constants.dart';
import 'package:flutter_core/core/services/device_info_service.dart';
import 'package:flutter_core/network/api_service.dart';
import '../domain/entities/user_entity.dart';
import '../domain/repositories/i_auth_repository.dart';
import '../models/user_model.dart';

class AuthRepository implements IAuthRepository {
  final ApiService apiService;
  final DeviceInfoService deviceInfo;

  AuthRepository({
    required this.apiService,
    required this.deviceInfo,
  });

  @override
  Future<UserEntity> login({
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

  @override
  Future<UserEntity> register({
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

  @override
  Future<bool> verifyOtp({
    required String code,
    String? email,
  }) async {
    return code.trim() == AppConstants.demoOtp;
  }
}
