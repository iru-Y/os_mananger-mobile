import 'package:json_annotation/json_annotation.dart';

part 'customer_request.g.dart';

@JsonSerializable()
class CustomerRequest {
  String? email;
  @JsonKey(name: "full_name")
  String? fullName;
  String? phone;
  String? description;
  String? price;

  CustomerRequest({
    this.email,
    this.fullName,
    this.phone,
    this.description,
    this.price,
  });
  factory CustomerRequest.fromJson(Map<String, dynamic> json) =>
      _$CustomerRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerRequestToJson(this);
}
