import 'package:json_annotation/json_annotation.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_param.dart';

part 'trigger_date_time_param.g.dart';

@JsonSerializable()
class TgDateTimeParam extends TriggerBaseParam {
  final String period;
  final String? startDate;
  final String? endDate;
  final String? date;
  final String? time;
  final List<String>? dayOfWeek;
  final List<String>? dayOfMonth;

  const TgDateTimeParam({
    required this.period,
    this.startDate,
    this.endDate,
    this.date,
    this.time,
    this.dayOfWeek,
    this.dayOfMonth,
  });

  @override
  List<Object?> get props =>
      [period, startDate, endDate, date, time, dayOfWeek, dayOfMonth];

  @override
  bool? get stringify => true;

  @override
  Map<String, dynamic> toJson() => _$TgDateTimeParamToJson(this);
}

/*
"data": {
			"period": "0",
			"startDate": null,
			"endDate": null,
			"Date": "20240820",
			"Time": "1900",
			"dayOfWeek": null,
			"dayOfMonth" : null
		},
 */
