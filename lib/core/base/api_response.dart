class ApiResponse<T> {
  final T? data;
  final String? message;
  final bool success;

  ApiResponse({
    this.data,
    this.message,
    this.success = false,
  });

  factory ApiResponse.success(T data) {
    return ApiResponse(
      data: data,
      success: true,
    );
  }

  factory ApiResponse.error(String message) {
    return ApiResponse(
      message: message,
      success: false,
    );
  }
}
