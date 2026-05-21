import 'package:flutter_core/core/utils/app_toast.dart';

/// Backward-compatible loader — delegates to EasyLoading.
class Loading {
  static void show([String? message]) => AppToast.showLoading(message);

  static void hide() => AppToast.dismiss();
}
