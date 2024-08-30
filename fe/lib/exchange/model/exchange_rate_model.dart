import 'package:json_annotation/json_annotation.dart';
import 'package:shinhan_flow/account/model/account_model.dart';
import 'package:shinhan_flow/common/model/default_model.dart';
import 'package:shinhan_flow/trigger/model/enum/time_category.dart';

import '../../trigger/model/enum/foreign_currency_category.dart';

part 'exchange_rate_model.g.dart';

@JsonSerializable()
class ExchangeRateModel extends BaseModel {
  final int id;
  final CurrencyType currency;
  final double exchangeRate;
  final int exchangeMin;
  final String created;

  ExchangeRateModel({
    required this.id,
    required this.currency,
    required this.exchangeRate,
    required this.exchangeMin,
    required this.created,
  });

  factory ExchangeRateModel.fromJson(Map<String, dynamic> json) =>
      _$ExchangeRateModelFromJson(json);
}
