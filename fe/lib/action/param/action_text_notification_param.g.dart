// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_text_notification_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcTextNotificationParam _$AcTextNotificationParamFromJson(
        Map<String, dynamic> json) =>
    AcTextNotificationParam(
      text: json['text'] as String,
      type: $enumDecodeNullable(_$ActionTypeEnumMap, json['type']) ??
          ActionType.TextNotificationAction,
    );

Map<String, dynamic> _$AcTextNotificationParamToJson(
        AcTextNotificationParam instance) =>
    <String, dynamic>{
      'type': _$ActionTypeEnumMap[instance.type]!,
      'text': instance.text,
    };

const _$ActionTypeEnumMap = {
  ActionType.BalanceNotificationAction: 'BalanceNotificationAction',
  ActionType.ExchangeRateNotificationAction: 'ExchangeRateNotificationAction',
  ActionType.TextNotificationAction: 'TextNotificationAction',
  ActionType.ExchangeAction: 'ExchangeAction',
  ActionType.TransferAction: 'TransferAction',
};
