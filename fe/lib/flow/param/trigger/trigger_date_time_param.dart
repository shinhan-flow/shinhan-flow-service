import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_param.dart';
import 'package:shinhan_flow/trigger/model/enum/time_category.dart';

import '../../provider/widget/time_form_provider.dart';
import '../enum/flow_type.dart';

part 'trigger_date_time_param.g.dart';

@JsonSerializable()
class TgDateTimeParam extends TriggerBaseParam {
  /// 일반
  final String? date;

  /// 기간
  // @JsonKey(name: 'start_date')
  final String? startDate;

  // @JsonKey(name: 'end_date')
  final String? endDate;

  /// 여러 요일
  // @JsonKey(name: 'day_of_week')
  final List<DayOfWeek>? dayOfWeek;

  // @JsonKey(name: 'day_of_month')
  final List<int>? dayOfMonth;
  final List<String>? dates;

  // @JsonKey(name: 'specific_time')
  final String? specificTime;

  TgDateTimeParam({
    this.startDate,
    this.endDate,
    this.date,
    this.specificTime,
    this.dayOfWeek,
    this.dayOfMonth,
    this.dates,
    required super.type,
  });

  @override
  List<Object?> get props => [
        type,
        startDate,
        endDate,
        date,
        specificTime,
        dayOfWeek,
        dayOfMonth,
        dates,
      ];

  @override
  bool? get stringify => true;

  factory TgDateTimeParam.fromForm({required TgDateTimeFormModel form}) {
    if (form.type != null) {
      switch (form.type) {
        case TriggerType.SpecificDateTrigger:
          return TgDateTimeParam(date: form.date, type: form.type!);
        case TriggerType.PeriodDateTrigger:
          return TgDateTimeParam(
              startDate: form.startDate,
              endDate: form.endDate,
              type: form.type!);
        case TriggerType.DayOfWeekTrigger:
          return TgDateTimeParam(dayOfWeek: form.dayOfWeek, type: form.type!);
        case TriggerType.DayOfMonthTrigger:
          return TgDateTimeParam(dayOfMonth: form.dayOfMonth, type: form.type!);
        default:
          break;
      }
    }
    return TgDateTimeParam(type: form.type!);
  }

  @override
  Map<String, dynamic> toJson() => _$TgDateTimeParamToJson(this);
}

@JsonSerializable()
class TgSpecificDateParam extends TriggerBaseParam {
  final String? localDate;

  TgSpecificDateParam({
    this.localDate,
    super.type = TriggerType.SpecificDateTrigger,
  });

  @override
  List<Object?> get props => [
        type,
        localDate,
      ];

  @override
  bool? get stringify => true;

  factory TgSpecificDateParam.fromForm({required TgDateTimeFormModel form}) {
    return TgSpecificDateParam(type: form.type, localDate: form.date!);
  }

  @override
  Map<String, dynamic> toJson() => _$TgSpecificDateParamToJson(this);
}

@JsonSerializable()
class TgPeriodDateParam extends TriggerBaseParam {
  /// 기간
  final String? startDate;
  final String? endDate;

  TgPeriodDateParam({
    this.startDate,
    this.endDate,
    super.type = TriggerType.PeriodDateTrigger,
  });

  @override
  List<Object?> get props => [type, startDate, endDate];

  @override
  bool? get stringify => true;

  factory TgPeriodDateParam.fromForm({required TgDateTimeFormModel form}) {
    return TgPeriodDateParam(
        type: form.type, startDate: form.startDate!, endDate: form.endDate!);
  }

  @override
  Map<String, dynamic> toJson() => _$TgPeriodDateParamToJson(this);
}

@JsonSerializable()
class TgDayOfWeekParam extends TriggerBaseParam {
  /// 요일을 설정하는 트리거 생성
  final List<DayOfWeek>? dayOfWeek;

  TgDayOfWeekParam({
    this.dayOfWeek,
    super.type = TriggerType.DayOfWeekTrigger,
  });

  @override
  List<Object?> get props => [
        type,
        dayOfWeek,
      ];

  @override
  bool? get stringify => true;

  factory TgDayOfWeekParam.fromForm({required TgDateTimeFormModel form}) {
    // form.dayOfWeek!.sort();
    return TgDayOfWeekParam(
      type: form.type,
      dayOfWeek: form.dayOfWeek!,
    );
  }

  @override
  Map<String, dynamic> toJson() => _$TgDayOfWeekParamToJson(this);
}

@JsonSerializable()
class TgDayOfMonthParam extends TriggerBaseParam {
  /// 요일을 설정하는 트리거 생성
  final List<int>? days;

  TgDayOfMonthParam({
    this.days,
    super.type = TriggerType.DayOfMonthTrigger,
  });

  @override
  List<Object?> get props => [
        type,
        days,
      ];

  @override
  bool? get stringify => true;

  factory TgDayOfMonthParam.fromForm({required TgDateTimeFormModel form}) {
    form.dayOfMonth!.sort();
    return TgDayOfMonthParam(
      type: form.type,
      days: form.dayOfMonth!,
    );
  }

  @override
  Map<String, dynamic> toJson() => _$TgDayOfMonthParamToJson(this);
}

@JsonSerializable()
class TgTimeParam extends TriggerBaseParam {
  /// 요일을 설정하는 트리거 생성
  final String time;

  TgTimeParam({
    this.time = "00:00:00",
    super.type = TriggerType.SpecificTimeTrigger,
  });

  @override
  List<Object?> get props => [
        type,
        time,
      ];

  @override
  bool? get stringify => true;

  // factory TgTimeParam.fromForm({required TgDateTimeFormModel form}) {
  //   // form.dayOfWeek!.sort();
  //   return TgTimeParam(
  //     type: form.type,
  //     time: form.time!,
  //   );
  // }

  @override
  Map<String, dynamic> toJson() => _$TgTimeParamToJson(this);
}

final timeProvider = StateProvider.autoDispose<String>((ref) => "00:00:00");
