import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarComponent extends StatelessWidget {
  const CalendarComponent({super.key});

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
      // rangeStartDecoration: rangeEndDay != null
      //     ? boxDecoration.copyWith(
      //         color: validRangeDate()
      //             ? const Color(0xFF4065F6)
      //             : const Color(0xFFFC0000),
      //         borderRadius: BorderRadiusDirectional.horizontal(
      //             start: Radius.circular(8.r)))
      //     : boxDecoration.copyWith(
      //         color: validRangeStartDay()
      //             ? const Color(0xFF4065F6)
      //             : const Color(0xFFFC0000)),
      // rangeEndDecoration: boxDecoration.copyWith(
      //     color: validRangeDate()
      //         ? const Color(0xFF4065F6)
      //         : const Color(0xFFFC0000),
      //     borderRadius:
      //         BorderRadiusDirectional.horizontal(end: Radius.circular(8.r))),
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
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime.now(),
      lastDay: DateTime(2999),
      headerStyle: getHeaderStyle(),
      calendarStyle: getCalendarStyle(),
      daysOfWeekStyle: getDaysOfWeekStyle(),
    );
  }
}
