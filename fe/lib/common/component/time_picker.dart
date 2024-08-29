import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_date_time_param.dart';
import 'package:shinhan_flow/theme/text_theme.dart';

class CustomTimePicker extends ConsumerStatefulWidget {
  const CustomTimePicker({super.key});

  @override
  ConsumerState<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends ConsumerState<CustomTimePicker> {
  late final FixedExtentScrollController timePeriodController;
  late final FixedExtentScrollController hourController;
  late final FixedExtentScrollController minController;

  bool isAfternoon = false;
  int selectedHour = 0;
  int selectedMinute = 0;

  @override
  void initState() {
    super.initState();
    timePeriodController =
        FixedExtentScrollController(initialItem: isAfternoon ? 1 : 0);
    hourController = FixedExtentScrollController(initialItem: selectedHour);
    minController =
        FixedExtentScrollController(initialItem: selectedMinute ~/ 10);
  }

  Widget selectionOverlay() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.all(Radius.circular(8.r)),
          color: CupertinoDynamicColor.resolve(
              Colors.grey.withOpacity(0.2), context),
        ),
      );

  String oneDigitFormat(int n) {
    return n < 10 ? "0$n" : n.toString();
  }

  void changeSelectDate() {
    int twelveAmPm = 0;
    if (selectedHour == 12) {
      twelveAmPm = isAfternoon ? -12 : 0;
    }

    final hour = (selectedHour + (isAfternoon ? 12 : 0) + twelveAmPm)
        .toString()
        .padLeft(2, '0');
    final min = selectedMinute.toString().padLeft(2, '0');
    final String time = "$hour:$min:00";
    ref.read(timeProvider.notifier).update((t) => time);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(timeProvider);

    return Row(
      children: <Widget>[
        Flexible(
          child: CupertinoPicker(
              itemExtent: 32.h,
              diameterRatio: 10,
              squeeze: 1.0,
              onSelectedItemChanged: (int index) {
                setState(() {
                  if (index == 0) {
                    isAfternoon = false;
                  } else {
                    isAfternoon = true;
                  }
                  changeSelectDate();
                });
              },
              selectionOverlay: selectionOverlay(),
              scrollController: timePeriodController,
              children: ['오전', '오후']
                  .mapIndexed((index, e) => Center(
                      child: Text(e,
                          style: SHFlowTextStyle.labelBold.copyWith(
                            color: isAfternoon && index == 1 ||
                                    !isAfternoon && index == 0
                                ? const Color(0xFF0057FF)
                                : Colors.grey,
                          ))))
                  .toList() //generateDateItems(),
              ),
        ),
        SizedBox(width: 7.w),
        Flexible(
          child: CupertinoPicker(
            itemExtent: 32.h,
            diameterRatio: 10,
            squeeze: 1.0,
            onSelectedItemChanged: (int index) {
              setState(() {
                selectedHour = index;
                changeSelectDate();
              });
            },
            looping: true,
            selectionOverlay: selectionOverlay(),
            scrollController: hourController,
            children: List<Widget>.generate(12, (int index) {
              return Center(
                  child: Text(index == 0 ? '12' : oneDigitFormat(index),
                      style: SHFlowTextStyle.labelBold.copyWith(
                        color: selectedHour == index
                            ? const Color(0xFF0057FF)
                            : Colors.grey,
                      )));
            }),
          ),
        ),
        SizedBox(width: 7.w),
        Flexible(
          child: CupertinoPicker(
            itemExtent: 32.h,
            diameterRatio: 10,
            squeeze: 1.0,
            onSelectedItemChanged: (int index) {
              setState(() {
                selectedMinute = index * 10;
                changeSelectDate();
              });
            },
            looping: true,
            selectionOverlay: selectionOverlay(),
            scrollController: minController,
            children: List<Widget>.generate(6, (int index) {
              return Center(
                  child: Text(
                oneDigitFormat(index * 10),
                style: SHFlowTextStyle.labelBold.copyWith(
                  color: selectedMinute ~/ 10 == index
                      ? const Color(0xFF0057FF)
                      : Colors.grey,
                ),
              ));
            }),
          ),
        ),
      ],
    );
  }
}
