class BaseStruct<T> {
  String? status;
  T? data;

  BaseStruct({this.status, this.data});

  factory BaseStruct.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return BaseStruct(
      status: json['status'],
      data: json['data'] != null
          ? fromJsonT(json['data']) 
          : null,
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'status': status,
      'data': data != null ? toJsonT(data!) : null,
    };
  }
}
