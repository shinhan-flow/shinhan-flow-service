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
        case TriggerType.specificDate:
          return TgDateTimeParam(date: form.date, type: form.type!);
        case TriggerType.periodDate:
          return TgDateTimeParam(
              startDate: form.startDate,
              endDate: form.endDate,
              type: form.type!);
        case TriggerType.dayOfWeek:
          return TgDateTimeParam(dayOfWeek: form.dayOfWeek, type: form.type!);
        case TriggerType.dayOfMonth:
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
