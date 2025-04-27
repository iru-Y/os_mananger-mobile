import 'package:json_annotation/json_annotation.dart';

part 'customer_model.g.dart';

@JsonSerializable()
class CustomerModel {
  int? id;
  String? email;
  @JsonKey(name: 'full_name')
  String? fullName;
  String? phone;
  String? description;
  String? price;

  CustomerModel({
    this.id,
    this.email,
    this.fullName,
    this.phone,
    this.description,
    this.price,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}
