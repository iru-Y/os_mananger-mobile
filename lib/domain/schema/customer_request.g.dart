// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerRequest _$CustomerRequestFromJson(Map<String, dynamic> json) =>
    CustomerRequest(
      email: json['email'] as String?,
      fullName: json['full_name'] as String?,
      phone: json['phone'] as String?,
      description: json['description'] as String?,
      price: json['price'] as String?,
    );

Map<String, dynamic> _$CustomerRequestToJson(CustomerRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'full_name': instance.fullName,
      'phone': instance.phone,
      'description': instance.description,
      'price': instance.price,
    };
