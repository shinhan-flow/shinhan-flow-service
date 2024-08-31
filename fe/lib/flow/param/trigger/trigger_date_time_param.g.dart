// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trigger_date_time_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TgDateTimeParam _$TgDateTimeParamFromJson(Map<String, dynamic> json) =>
    TgDateTimeParam(
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      date: json['date'] as String?,
      specificTime: json['specificTime'] as String?,
      daysOfWeek: (json['daysOfWeek'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$DayOfWeekEnumMap, e))
          .toList(),
      dayOfMonth: (json['dayOfMonth'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      dates:
          (json['dates'] as List<dynamic>?)?.map((e) => e as String).toList(),
      type: $enumDecode(_$TriggerTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$TgDateTimeParamToJson(TgDateTimeParam instance) =>
    <String, dynamic>{
      'type': _$TriggerTypeEnumMap[instance.type]!,
      'date': instance.date,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'daysOfWeek':
          instance.daysOfWeek?.map((e) => _$DayOfWeekEnumMap[e]!).toList(),
      'dayOfMonth': instance.dayOfMonth,
      'dates': instance.dates,
      'specificTime': instance.specificTime,
    };

const _$DayOfWeekEnumMap = {
  DayOfWeek.MONDAY: 'MONDAY',
  DayOfWeek.TUESDAY: 'TUESDAY',
  DayOfWeek.WEDNESDAY: 'WEDNESDAY',
  DayOfWeek.THURSDAY: 'THURSDAY',
  DayOfWeek.FRIDAY: 'FRIDAY',
  DayOfWeek.SATURDAY: 'SATURDAY',
  DayOfWeek.SUNDAY: 'SUNDAY',
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

TgSpecificDateParam _$TgSpecificDateParamFromJson(Map<String, dynamic> json) =>
    TgSpecificDateParam(
      localDate: json['localDate'] as String?,
      type: $enumDecodeNullable(_$TriggerTypeEnumMap, json['type']) ??
          TriggerType.SpecificDateTrigger,
    );

Map<String, dynamic> _$TgSpecificDateParamToJson(
        TgSpecificDateParam instance) =>
    <String, dynamic>{
      'type': _$TriggerTypeEnumMap[instance.type]!,
      'localDate': instance.localDate,
    };

TgPeriodDateParam _$TgPeriodDateParamFromJson(Map<String, dynamic> json) =>
    TgPeriodDateParam(
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      type: $enumDecodeNullable(_$TriggerTypeEnumMap, json['type']) ??
          TriggerType.PeriodDateTrigger,
    );

Map<String, dynamic> _$TgPeriodDateParamToJson(TgPeriodDateParam instance) =>
    <String, dynamic>{
      'type': _$TriggerTypeEnumMap[instance.type]!,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };

TgDayOfWeekParam _$TgDayOfWeekParamFromJson(Map<String, dynamic> json) =>
    TgDayOfWeekParam(
      daysOfWeek: (json['daysOfWeek'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$DayOfWeekEnumMap, e))
          .toList(),
      type: $enumDecodeNullable(_$TriggerTypeEnumMap, json['type']) ??
          TriggerType.DayOfWeekTrigger,
    );

Map<String, dynamic> _$TgDayOfWeekParamToJson(TgDayOfWeekParam instance) =>
    <String, dynamic>{
      'type': _$TriggerTypeEnumMap[instance.type]!,
      'daysOfWeek':
          instance.daysOfWeek?.map((e) => _$DayOfWeekEnumMap[e]!).toList(),
    };

TgDayOfMonthParam _$TgDayOfMonthParamFromJson(Map<String, dynamic> json) =>
    TgDayOfMonthParam(
      days: (json['days'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      type: $enumDecodeNullable(_$TriggerTypeEnumMap, json['type']) ??
          TriggerType.DayOfMonthTrigger,
    );

Map<String, dynamic> _$TgDayOfMonthParamToJson(TgDayOfMonthParam instance) =>
    <String, dynamic>{
      'type': _$TriggerTypeEnumMap[instance.type]!,
      'days': instance.days,
    };

TgTimeParam _$TgTimeParamFromJson(Map<String, dynamic> json) => TgTimeParam(
      time: json['time'] as String? ?? "00:00:00",
      type: $enumDecodeNullable(_$TriggerTypeEnumMap, json['type']) ??
          TriggerType.SpecificTimeTrigger,
    );

Map<String, dynamic> _$TgTimeParamToJson(TgTimeParam instance) =>
    <String, dynamic>{
      'type': _$TriggerTypeEnumMap[instance.type]!,
      'time': instance.time,
    };
