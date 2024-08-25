import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shinhan_flow/flow/provider/widget/time_form_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarComponent extends ConsumerWidget {
  final RangeSelectionMode rangeSelectionMode;

  const CalendarComponent({super.key, required this.rangeSelectionMode});

  HeaderStyle getHeaderStyle() {
    final format = DateFormat('y년 M월');
    final titleTextStyle = TextStyle(
      fontSize: 16.sp,
      letterSpacing: -0.25.sp,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF454545),
    );
    return HeaderStyle(
      headerPadding: EdgeInsets.zero,
      titleTextFormatter: (date, locale) => format.format(date),
      // leftChevronPadding: EdgeInsets.only(left: 50.w, top: 28.h),
      leftChevronMargin: EdgeInsets.only(left: 50.w),
      // rightChevronPadding:EdgeInsets.only(right: 50.w),
      rightChevronMargin: EdgeInsets.only(right: 50.w),
      titleCentered: true,
      formatButtonVisible: false,
      titleTextStyle: titleTextStyle,
    );
  }

  CalendarStyle getCalendarStyle() {
    final textStyle = TextStyle(
      fontSize: 14.sp,
      letterSpacing: -0.25.sp,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF333333),
    );
    final BoxDecoration boxDecoration = BoxDecoration(
      color: const Color(0xFF4065F6),
      borderRadius: BorderRadius.circular(8.r),
    );

    return CalendarStyle(
      cellMargin: EdgeInsets.symmetric(
        vertical: 4.h,
      ),
      todayTextStyle: textStyle.copyWith(color: Colors.white),
      weekendTextStyle: textStyle,
      outsideTextStyle: textStyle.copyWith(color: const Color(0xFF969696)),
      defaultTextStyle: textStyle,
      withinRangeDecoration: const BoxDecoration(color: Color(0xFF4065F6)),
      selectedDecoration: boxDecoration,
      rangeEndTextStyle: textStyle.copyWith(color: Colors.white),
      rangeStartTextStyle: textStyle.copyWith(color: Colors.white),
      withinRangeTextStyle: textStyle.copyWith(color: Colors.white),
      todayDecoration: boxDecoration.copyWith(
        color: const Color(0xFF4065F6),
      ),
      // isTodayHighlighted: false,
      rangeHighlightScale: 1.0,
      rangeHighlightColor: const Color(0xFF4065F6),
      rangeStartDecoration: boxDecoration.copyWith(
        color: const Color(0xFF4065F6),
      ),
      rangeEndDecoration: boxDecoration.copyWith(
          color: const Color(0xFF4065F6),
          borderRadius:
              BorderRadiusDirectional.horizontal(end: Radius.circular(8.r))),
      weekendDecoration: boxDecoration.copyWith(color: Colors.transparent),
      defaultDecoration: boxDecoration.copyWith(color: Colors.transparent),
      outsideDecoration: boxDecoration.copyWith(color: Colors.transparent),
      tablePadding: EdgeInsets.only(left: 24.r, right: 24.r, bottom: 12.r),
    );
  }

  DaysOfWeekStyle getDaysOfWeekStyle() {
    final textStyle = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF333333),
    );
    return DaysOfWeekStyle(
      dowTextFormatter: (date, locale) => DateFormat.E('ko').format(date)[0],
      weekendStyle: textStyle,
      weekdayStyle: textStyle,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final form = ref.watch(tgDateTimeFormProvider);
    DateTime? focusDay = form.date != null ? DateTime.parse(form.date!) : null;
    DateTime? rangeStartDay =
        form.startDate != null ? DateTime.parse(form.startDate!) : null;
    DateTime? rangeEndDay =
        form.endDate != null ? DateTime.parse(form.endDate!) : null;

    return TableCalendar(
      onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
        log('selectedDay = ${selectedDay}');
        log('focusedDay = ${focusedDay}');
        String date = dateFormat.format(selectedDay);
        ref.read(tgDateTimeFormProvider.notifier).update(date: date);
      },
      onRangeSelected: (DateTime? start, DateTime? end, DateTime focusedDay) {
        log('start = ${start}');
        log('end = ${end}');
        log('focusedDay = ${focusedDay}');
        String? startDate = start != null ? dateFormat.format(start) : null;
        String? endDate = end != null ? dateFormat.format(end) : null;
        String focusDay = dateFormat.format(focusedDay);
        if (endDate == null) {
          ref
              .read(tgDateTimeFormProvider.notifier)
              .clearEndDate(startDate: startDate, date: startDate);
        } else {
          ref
              .read(tgDateTimeFormProvider.notifier)
              .update(startDate: startDate, endDate: endDate, date: focusDay);
        }
      },
      focusedDay: focusDay ?? DateTime.now(),
      firstDay: DateTime(2024),
      lastDay: DateTime(2999),
      currentDay: focusDay,
      rangeSelectionMode: rangeSelectionMode,
      rangeStartDay: rangeStartDay,
      rangeEndDay: rangeEndDay,
      headerStyle: getHeaderStyle(),
      calendarStyle: getCalendarStyle(),
      daysOfWeekStyle: getDaysOfWeekStyle(),
    );
  }
}
