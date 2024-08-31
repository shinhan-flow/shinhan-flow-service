// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trigger_exchange_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TgExchangeParam _$TgExchangeParamFromJson(Map<String, dynamic> json) =>
    TgExchangeParam(
      currency: $enumDecodeNullable(_$CurrencyTypeEnumMap, json['currency']),
      rate: (json['rate'] as num?)?.toDouble(),
      type: $enumDecodeNullable(_$TriggerTypeEnumMap, json['type']) ??
          TriggerType.ExchangeRateTrigger,
    );

Map<String, dynamic> _$TgExchangeParamToJson(TgExchangeParam instance) =>
    <String, dynamic>{
      'type': _$TriggerTypeEnumMap[instance.type]!,
      'currency': _$CurrencyTypeEnumMap[instance.currency],
      'rate': instance.rate,
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

const _$TriggerTypeEnumMap = {
  TriggerType.BalanceTrigger: 'BalanceTrigger',
  TriggerType.DepositTrigger: 'DepositTrigger',
  TriggerType.TransferTrigger: 'TransferTrigger',
  TriggerType.WithDrawTrigger: 'WithDrawTrigger',
  TriggerType.SpecificDateTrigger: 'SpecificDateTrigger',
  TriggerType.PeriodDateTrigger: 'PeriodDateTrigger',
  TriggerType.DayOfWeekTrigger: 'DayOfWeekTrigger',
  TriggerType.DayOfMonthTrigger: 'DayOfMonthTrigger',
  TriggerType.ExchangeRateTrigger: 'ExchangeRateTrigger',
  TriggerType.InterestRateTrigger: 'InterestRateTrigger',
  TriggerType.SpecificTimeTrigger: 'SpecificTimeTrigger',
};
