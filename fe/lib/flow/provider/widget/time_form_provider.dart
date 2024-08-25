import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shinhan_flow/flow/provider/widget/flow_form_provider.dart';

import '../../../common/model/base_form_model.dart';
import '../../../common/param/default_param.dart';
import '../../../trigger/model/enum/time_category.dart';
import '../../param/enum/flow_type.dart';
import '../../param/trigger/trigger_date_time_param.dart';
import '../../param/trigger/trigger_param.dart';

part 'time_form_provider.g.dart';

@immutable
class TgDateTimeFormModel extends TgDateTimeParam with BaseFormModel {
  final FlowType? flowType;

  TgDateTimeFormModel({
    super.startDate,
    super.endDate,
    super.date,
    super.specificTime,
    super.dayOfWeek,
    super.dayOfMonth,
    super.dates,
    this.flowType,
    bool valid = false,
  }) {
    this.valid = valid;
  }

  bool validation(
    String? startDate,
    String? endDate,
    String? date,
    String? specificTime,
    List<DayOfWeek>? dayOfWeek,
    List<int>? dayOfMonth,
    List<String>? dates,
  ) {
    if (flowType != null) {
      switch (flowType!) {
        case FlowType.specificDate:
          return date != null && date.isNotEmpty;
        case FlowType.specificTime:
          return specificTime != null && specificTime.isNotEmpty;
        case FlowType.periodDate:
          if (startDate != null && endDate != null) {
            // 기간이 start ~ end
            // 동일하거나 start 가 end 보다 이후일 경우 false
            return DateTime.parse(startDate)
                    .compareTo(DateTime.parse(endDate)) ==
                -1;
          }
          return false;
        case FlowType.dayOfWeek:
          // log("valid dayOfWeek = $dayOfWeek");
          return dayOfWeek != null && dayOfWeek.isNotEmpty;
        case FlowType.dayOfMonth:
          return dayOfMonth != null && dayOfMonth.isNotEmpty;
        case FlowType.multiDate:
          return dates != null && dates.isNotEmpty;
        default:
          return false;
      }
    }

    return false;
  }

  TgDateTimeFormModel copyWith({
    FlowType? flowType,
    String? startDate,
    String? endDate,
    String? date,
    String? specificTime,
    List<DayOfWeek>? dayOfWeek,
    List<int>? dayOfMonth,
    List<String>? dates,
  }) {
    String? validStartDate = startDate ?? this.startDate;
    String? validEndDate = endDate ?? this.endDate;
    String? validDate = date ?? this.date;
    if (flowType != null && flowType == FlowType.specificDate) {
      validEndDate = null;
      validStartDate = null;
    } else if (flowType != null && flowType == FlowType.periodDate) {
      validDate = null;
    }

    final validSpecificTime = specificTime ?? this.specificTime;
    final validDayOfWeek = dayOfWeek ?? this.dayOfWeek;
    final validDayOfMonth = dayOfMonth ?? this.dayOfMonth;
    final validDates = dates ?? this.dates;
    final valid = validation(
      validStartDate,
      validEndDate,
      validDate,
      validSpecificTime,
      validDayOfWeek,
      validDayOfMonth,
      validDates,
    );
    return TgDateTimeFormModel(
      startDate: validStartDate,
      endDate: validEndDate,
      date: validDate,
      specificTime: validSpecificTime,
      dayOfWeek: validDayOfWeek,
      dayOfMonth: validDayOfMonth,
      dates: validDates,
      valid: valid,
      flowType: flowType ?? this.flowType,
    );
  }

  TgDateTimeFormModel clearEndDate({
    String? startDate,
    String? date,
  }) {
    final validStartDate = startDate ?? this.startDate;
    return TgDateTimeFormModel(
      startDate: validStartDate,
      endDate: null,
      date: date,
      specificTime: specificTime,
      dayOfWeek: dayOfWeek,
      dayOfMonth: dayOfMonth,
      dates: dates,
      valid: valid,
      flowType: flowType,
    );
  }

  DefaultParam toParam() {
    return TriggerParam(
      code: flowType!,
      data: TgDateTimeParam.fromForm(form: this),
    );
  }
}

@riverpod
class TgDateTimeForm extends _$TgDateTimeForm {
  @override
  TgDateTimeFormModel build() {
    return TgDateTimeFormModel();
  }

  void clearEndDate({required String? startDate, required String? date}) {
    state = state.clearEndDate(startDate: startDate, date: date);
  }

  void update({
    FlowType? flowType,
    String? startDate,
    String? endDate,
    String? date,
    String? specificTime,
    List<DayOfWeek>? dayOfWeek,
    List<int>? dayOfMonth,
    List<String>? dates,
  }) {
    state = state.copyWith(
      flowType: flowType,
      startDate: startDate,
      endDate: endDate,
      date: date,
      specificTime: specificTime,
      dayOfWeek: dayOfWeek,
      dayOfMonth: dayOfMonth,
      dates: dates,
    );
  }
}
