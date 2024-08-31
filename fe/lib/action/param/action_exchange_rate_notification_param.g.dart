// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_exchange_rate_notification_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcExchangeRateNotificationParam _$AcExchangeRateNotificationParamFromJson(
        Map<String, dynamic> json) =>
    AcExchangeRateNotificationParam(
      currency: $enumDecode(_$CurrencyTypeEnumMap, json['currency']),
      type: $enumDecodeNullable(_$ActionTypeEnumMap, json['type']) ??
          ActionType.ExchangeRateNotificationAction,
    );

Map<String, dynamic> _$AcExchangeRateNotificationParamToJson(
        AcExchangeRateNotificationParam instance) =>
    <String, dynamic>{
      'type': _$ActionTypeEnumMap[instance.type]!,
      'currency': _$CurrencyTypeEnumMap[instance.currency]!,
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
