import 'package:json_annotation/json_annotation.dart';

part 'monthly_summary_response.g.dart';

@JsonSerializable()
class MonthlySummaryResponse {
  @JsonKey(name: "total_cost_price")
  final String? totalCostPrice;

  @JsonKey(name: "total_service_price")
  final String? totalService;

  @JsonKey(name: "total_profit")
  final String? totalProfit;

  MonthlySummaryResponse({
    this.totalCostPrice,
    this.totalService,
    this.totalProfit,
  });

  factory MonthlySummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$MonthlySummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MonthlySummaryResponseToJson(this);
}
