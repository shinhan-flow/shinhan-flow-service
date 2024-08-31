// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trigger_deposit_account_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TgAccountDepositParam _$TgAccountDepositParamFromJson(
        Map<String, dynamic> json) =>
    TgAccountDepositParam(
      account: json['account'] as String,
      amount: (json['amount'] as num).toInt(),
      type: $enumDecode(_$TriggerTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$TgAccountDepositParamToJson(
        TgAccountDepositParam instance) =>
    <String, dynamic>{
      'type': _$TriggerTypeEnumMap[instance.type]!,
      'account': instance.account,
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
