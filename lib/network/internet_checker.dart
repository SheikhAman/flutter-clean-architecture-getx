import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetChecker {
  static Future<bool> hasInternet() async {
    try {
      final connectivity = await Connectivity().checkConnectivity();

      if (connectivity.contains(ConnectivityResult.none)) {
        return false;
      }

      final result = await InternetAddress.lookup('google.com');

      return result.isNotEmpty &&
          result.first.rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }
}