// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_exchange_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcExchangeParam _$AcExchangeParamFromJson(Map<String, dynamic> json) =>
    AcExchangeParam(
      currency: $enumDecode(_$CurrencyTypeEnumMap, json['currency']),
      fromAccount: json['fromAccount'] as String,
      amount: (json['amount'] as num).toInt(),
      type: $enumDecodeNullable(_$ActionTypeEnumMap, json['type']) ??
          ActionType.ExchangeAction,
    );

Map<String, dynamic> _$AcExchangeParamToJson(AcExchangeParam instance) =>
    <String, dynamic>{
      'type': _$ActionTypeEnumMap[instance.type]!,
      'currency': _$CurrencyTypeEnumMap[instance.currency]!,
      'fromAccount': instance.fromAccount,
      'amount': instance.amount,
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

const _$ActionTypeEnumMap = {
  ActionType.BalanceNotificationAction: 'BalanceNotificationAction',
  ActionType.ExchangeRateNotificationAction: 'ExchangeRateNotificationAction',
  ActionType.TextNotificationAction: 'TextNotificationAction',
  ActionType.ExchangeAction: 'ExchangeAction',
  ActionType.TransferAction: 'TransferAction',
};
