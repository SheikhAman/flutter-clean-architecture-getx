import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';

class DeviceInfoService extends GetxService {
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  Future<Map<String, dynamic>> getDevicePayload() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await _deviceInfoPlugin.androidInfo;
        return {
          'model': androidInfo.model,
          'brand': androidInfo.brand,
          'version': androidInfo.version.release,
          'platform': 'android',
        };
      } else if (Platform.isIOS) {
        final iosInfo = await _deviceInfoPlugin.iosInfo;
        return {
          'model': iosInfo.utsname.machine,
          'name': iosInfo.name,
          'version': iosInfo.systemVersion,
          'platform': 'ios',
        };
      }
    } catch (_) {}
    return {'platform': Platform.operatingSystem};
  }
}
