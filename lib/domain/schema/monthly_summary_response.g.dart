// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_summary_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonthlySummaryResponse _$MonthlySummaryResponseFromJson(
  Map<String, dynamic> json,
) => MonthlySummaryResponse(
  totalCostPrice: json['total_cost_price'] as String?,
  totalService: json['total_service_price'] as String?,
  totalProfit: json['total_profit'] as String?,
);

Map<String, dynamic> _$MonthlySummaryResponseToJson(
  MonthlySummaryResponse instance,
) => <String, dynamic>{
  'total_cost_price': instance.totalCostPrice,
  'total_service_price': instance.totalService,
  'total_profit': instance.totalProfit,
};
