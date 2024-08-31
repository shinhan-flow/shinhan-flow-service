// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trigger_transfer_account_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TgAccountTransferParam _$TgAccountTransferParamFromJson(
        Map<String, dynamic> json) =>
    TgAccountTransferParam(
      fromAccount: json['fromAccount'] as String,
      amount: (json['amount'] as num).toInt(),
      type: $enumDecode(_$TriggerTypeEnumMap, json['type']),
      toAccount: json['toAccount'] as String,
    );

Map<String, dynamic> _$TgAccountTransferParamToJson(
        TgAccountTransferParam instance) =>
    <String, dynamic>{
      'type': _$TriggerTypeEnumMap[instance.type]!,
      'fromAccount': instance.fromAccount,
      'toAccount': instance.toAccount,
      'amount': instance.amount,
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
