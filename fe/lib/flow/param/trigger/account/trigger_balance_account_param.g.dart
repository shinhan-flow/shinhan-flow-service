// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trigger_balance_account_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TgAccountBalanceParam _$TgAccountBalanceParamFromJson(
        Map<String, dynamic> json) =>
    TgAccountBalanceParam(
      account: json['account'] as String,
      balance: (json['balance'] as num).toInt(),
      type: $enumDecode(_$TriggerTypeEnumMap, json['type']),
      condition: $enumDecode(_$ConditionEnumMap, json['condition']),
    );

Map<String, dynamic> _$TgAccountBalanceParamToJson(
        TgAccountBalanceParam instance) =>
    <String, dynamic>{
      'type': _$TriggerTypeEnumMap[instance.type]!,
      'account': instance.account,
      'balance': instance.balance,
      'condition': _$ConditionEnumMap[instance.condition]!,
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

const _$ConditionEnumMap = {
  Condition.LE: 'LE',
  Condition.GE: 'GE',
};
