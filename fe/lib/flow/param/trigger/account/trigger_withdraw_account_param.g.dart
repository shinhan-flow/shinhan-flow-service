// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trigger_withdraw_account_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TgAccountWithdrawParam _$TgAccountWithdrawParamFromJson(
        Map<String, dynamic> json) =>
    TgAccountWithdrawParam(
      account: json['account'] as String,
      amount: (json['amount'] as num).toInt(),
      type: $enumDecode(_$TriggerTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$TgAccountWithdrawParamToJson(
        TgAccountWithdrawParam instance) =>
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
