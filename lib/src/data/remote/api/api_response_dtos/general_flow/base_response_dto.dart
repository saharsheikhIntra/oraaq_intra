class BaseResponseDto<T> {
  String status;
  String message;
  T? data;

  BaseResponseDto({
    this.status = "",
    this.message = "",
    this.data,
  });

  factory BaseResponseDto.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic data) fromJsonT,
  ) =>
      BaseResponseDto(
        status: json['status'] is String ? json['status'] : "",
        message: json['message'] != null ? json['message'].toString() : "",
        data: json['data'] == null ? null : fromJsonT(json['data']),
      );

  //bool get success => null;
}
