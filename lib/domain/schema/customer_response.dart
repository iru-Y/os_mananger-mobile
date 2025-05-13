import 'package:json_annotation/json_annotation.dart';

part 'customer_response.g.dart';

@JsonSerializable()
class CustomerResponse {
  int? id;              
  String? email;
  @JsonKey(name: "full_name")
  String? fullName;
  String? phone;
  String? description;
  String? profit;

  CustomerResponse({
    this.id,
    this.email,
    this.fullName,
    this.phone,
    this.description,
    this.profit,
  });

  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}
