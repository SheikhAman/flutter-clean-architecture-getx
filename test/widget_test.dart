import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/core/constants/app_constants.dart';

void main() {
  test('demo OTP is configured for boilerplate auth', () {
    expect(AppConstants.demoOtp, '112345');
    expect(AppConstants.otpLength, 6);
  });
}
