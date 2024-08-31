// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_transfer_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcTransferParam _$AcTransferParamFromJson(Map<String, dynamic> json) =>
    AcTransferParam(
      toAccount: json['toAccount'] as String,
      amount: (json['amount'] as num).toInt(),
      fromAccount: json['fromAccount'] as String,
      type: $enumDecodeNullable(_$ActionTypeEnumMap, json['type']) ??
          ActionType.TransferAction,
      holder: json['holder'] as String?,
    );

Map<String, dynamic> _$AcTransferParamToJson(AcTransferParam instance) =>
    <String, dynamic>{
      'type': _$ActionTypeEnumMap[instance.type]!,
      'amount': instance.amount,
      'fromAccount': instance.fromAccount,
      'toAccount': instance.toAccount,
    };

const _$ActionTypeEnumMap = {
  ActionType.BalanceNotificationAction: 'BalanceNotificationAction',
  ActionType.ExchangeRateNotificationAction: 'ExchangeRateNotificationAction',
  ActionType.TextNotificationAction: 'TextNotificationAction',
  ActionType.ExchangeAction: 'ExchangeAction',
  ActionType.TransferAction: 'TransferAction',
};
