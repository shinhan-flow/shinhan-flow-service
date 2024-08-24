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
  @JsonKey(name: 'start_date')
  final String? startDate;
  @JsonKey(name: 'end_date')
  final String? endDate;

  /// 여러 요일
  @JsonKey(name: 'day_of_week')
  final List<DayOfWeek>? dayOfWeek;
  @JsonKey(name: 'day_of_month')
  final List<int>? dayOfMonth;
  final List<String>? dates;
  @JsonKey(name: 'specific_time')
  final String? specificTime;

  const TgDateTimeParam({
    this.startDate,
    this.endDate,
    this.date,
    this.specificTime,
    this.dayOfWeek,
    this.dayOfMonth,
    this.dates,
  });

  @override
  List<Object?> get props => [
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
    if (form.flowType != null) {
      switch (form.flowType) {
        case FlowType.specificDate:
          return TgDateTimeParam(date: form.date);
        case FlowType.periodDate:
          return TgDateTimeParam(
              startDate: form.startDate, endDate: form.endDate);
        case FlowType.dayOfWeek:
          return TgDateTimeParam(dayOfWeek: form.dayOfWeek);
        case FlowType.dayOfMonth:
          return TgDateTimeParam(dayOfMonth: form.dayOfMonth);
        default:
          break;
      }
    }
    return const TgDateTimeParam();
  }

  @override
  Map<String, dynamic> toJson() => _$TgDateTimeParamToJson(this);
}
