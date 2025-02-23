class BaseResponseDto2<T> {
  final T? data;

  BaseResponseDto2({this.data});

  factory BaseResponseDto2.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic data) fromJsonT,
  ) {
    return BaseResponseDto2(
      data: json['items'] == null ? null : fromJsonT(json['items']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': data,
    };
  }
}
