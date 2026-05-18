import 'app_exceptions.dart';

class ErrorHandler {
  static String handleError(dynamic error) {
    if (error is AppExceptions) {
      return error.message;
    }
    return "Something went wrong";
  }
}