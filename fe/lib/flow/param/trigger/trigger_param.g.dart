// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trigger_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActionBaseParam _$ActionBaseParamFromJson(Map<String, dynamic> json) =>
    ActionBaseParam(
      type: $enumDecode(_$ActionTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$ActionBaseParamToJson(ActionBaseParam instance) =>
    <String, dynamic>{
      'type': _$ActionTypeEnumMap[instance.type]!,
    };

const _$ActionTypeEnumMap = {
  ActionType.BalanceNotificationAction: 'BalanceNotificationAction',
  ActionType.ExchangeRateNotificationAction: 'ExchangeRateNotificationAction',
  ActionType.TextNotificationAction: 'TextNotificationAction',
  ActionType.ExchangeAction: 'ExchangeAction',
  ActionType.TransferAction: 'TransferAction',
};

TriggerBaseParam _$TriggerBaseParamFromJson(Map<String, dynamic> json) =>
    TriggerBaseParam(
      type: $enumDecode(_$TriggerTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$TriggerBaseParamToJson(TriggerBaseParam instance) =>
    <String, dynamic>{
      'type': _$TriggerTypeEnumMap[instance.type]!,
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
