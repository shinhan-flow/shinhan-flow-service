// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_rate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeRateModel _$ExchangeRateModelFromJson(Map<String, dynamic> json) =>
    ExchangeRateModel(
      currency: $enumDecode(_$CurrencyTypeEnumMap, json['currency']),
      exchangeRate: (json['exchangeRate'] as num).toDouble(),
      exchangeMin: (json['exchangeMin'] as num).toDouble(),
      created: json['created'] as String,
    );

Map<String, dynamic> _$ExchangeRateModelToJson(ExchangeRateModel instance) =>
    <String, dynamic>{
      'currency': _$CurrencyTypeEnumMap[instance.currency]!,
      'exchangeRate': instance.exchangeRate,
      'exchangeMin': instance.exchangeMin,
      'created': instance.created,
    };

const _$CurrencyTypeEnumMap = {
  CurrencyType.KRW: 'KRW',
  CurrencyType.USD: 'USD',
  CurrencyType.EUR: 'EUR',
  CurrencyType.JPY: 'JPY',
  CurrencyType.CNY: 'CNY',
  CurrencyType.GBP: 'GBP',
  CurrencyType.CHF: 'CHF',
  CurrencyType.CAD: 'CAD',
};
