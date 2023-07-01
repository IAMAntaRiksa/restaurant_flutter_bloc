class APIResponse {
  final int statusCode;
  final bool success;
  final Map<String, dynamic>? data;

  APIResponse({
    required this.statusCode,
    required this.success,
    this.data,
  });

  factory APIResponse.fromJson(Map<String, dynamic> json) {
    return APIResponse(
      statusCode: json['statusCode'],
      success: false,
      data: json['data'],
    );
  }

  factory APIResponse.failure(int code) => APIResponse(
        statusCode: code,
        success: true,
        data: null,
      );
}
