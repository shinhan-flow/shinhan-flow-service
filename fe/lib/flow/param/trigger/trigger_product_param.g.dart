// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trigger_product_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TgProductParam _$TgProductParamFromJson(Map<String, dynamic> json) =>
    TgProductParam(
      accountProduct: $enumDecodeNullable(
          _$AccountProductTypeEnumMap, json['accountProduct']),
      rate: (json['rate'] as num?)?.toDouble(),
      type: $enumDecodeNullable(_$TriggerTypeEnumMap, json['type']) ??
          TriggerType.InterestRateTrigger,
    );

Map<String, dynamic> _$TgProductParamToJson(TgProductParam instance) =>
    <String, dynamic>{
      'type': _$TriggerTypeEnumMap[instance.type]!,
      'accountProduct': _$AccountProductTypeEnumMap[instance.accountProduct],
      'rate': instance.rate,
    };

const _$AccountProductTypeEnumMap = {
  AccountProductType.DEPOSIT_ACCOUNT: 'DEPOSIT_ACCOUNT',
  AccountProductType.SAVING_ACCOUNT: 'SAVING_ACCOUNT',
  AccountProductType.LOAN_ACCOUNT: 'LOAN_ACCOUNT',
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
