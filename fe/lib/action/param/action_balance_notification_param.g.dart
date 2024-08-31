// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_balance_notification_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcBalanceNotificationParam _$AcBalanceNotificationParamFromJson(
        Map<String, dynamic> json) =>
    AcBalanceNotificationParam(
      type: $enumDecodeNullable(_$ActionTypeEnumMap, json['type']) ??
          ActionType.BalanceNotificationAction,
      account: json['account'] as String,
    );

Map<String, dynamic> _$AcBalanceNotificationParamToJson(
        AcBalanceNotificationParam instance) =>
    <String, dynamic>{
      'type': _$ActionTypeEnumMap[instance.type]!,
      'account': instance.account,
    };

const _$ActionTypeEnumMap = {
  ActionType.BalanceNotificationAction: 'BalanceNotificationAction',
  ActionType.ExchangeRateNotificationAction: 'ExchangeRateNotificationAction',
  ActionType.TextNotificationAction: 'TextNotificationAction',
  ActionType.ExchangeAction: 'ExchangeAction',
  ActionType.TransferAction: 'TransferAction',
};
