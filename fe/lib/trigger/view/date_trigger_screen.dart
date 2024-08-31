import 'dart:developer';
import 'dart:math' hide log;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shinhan_flow/common/component/bottom_nav_button.dart';
import 'package:shinhan_flow/common/component/default_appbar.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_date_time_param.dart';
import 'package:shinhan_flow/flow/provider/widget/flow_form_provider.dart';
import 'package:shinhan_flow/flow/provider/widget/time_form_provider.dart';
import 'package:shinhan_flow/theme/text_theme.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../common/component/default_text_button.dart';
import '../../common/component/table_calendar.dart';
import '../../common/component/time_picker.dart';
import '../../flow/param/enum/flow_type.dart';
import '../../flow/param/trigger/trigger_param.dart';
import '../model/enum/time_category.dart';

class DateTriggerScreen extends StatelessWidget {
  static String get routeName => 'dateTrigger';

  const DateTriggerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final valid =
              ref.watch(tgDateTimeFormProvider.select((tg) => tg.valid));
          return BottomNavButton(
            child: DefaultTextButton(
              onPressed: valid
                  ? () {
                      final trigger = ref.read(tgDateTimeFormProvider);

                      ref.read(flowFormProvider.notifier).addTrigger(
                          trigger: trigger.toParam() as TriggerBaseParam);
                      // final time = ref.read(timeProvider);
                      // final timeTrigger = TgTimeParam(
                      //     type: TriggerType.SpecificTimeTrigger, time: time);
                      // ref
                      //     .read(flowFormProvider.notifier)
                      //     .addTrigger(trigger: timeTrigger as TriggerBaseParam);

                      context.pop();
                    }
                  : null,
              text: '완료',
              able: valid,
            ),
          );
        },
      ),
      body: NestedScrollView(
          physics: NeverScrollableScrollPhysics(),
          headerSliverBuilder: (_, __) {
            return [
              DefaultAppBar(
                title: '날짜 조건 설정',
                isSliver: true,
              )
            ];
          },
          body: CustomScrollView(
            physics: NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: _TimeCategoryComponent(),
              ),
              // SliverToBoxAdapter(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.stretch,
              //     children: [
              //       Padding(
              //         padding: EdgeInsets.symmetric(
              //             horizontal: 24.w, vertical: 12.h),
              //         child: Text(
              //           "시간을 설정해 주세요.",
              //           style: SHFlowTextStyle.form.copyWith(
              //             fontWeight: FontWeight.w600,
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 96.h,
              //         child: Padding(
              //             padding: EdgeInsets.symmetric(horizontal: 8.w),
              //             child: const CustomTimePicker()),
              //       ),
              //     ],
              //   ),
              // ),
              SliverFillRemaining(
                child: Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    final category = ref.watch(timeCategoryProvider);
                    RangeSelectionMode mode = RangeSelectionMode.toggledOff;
                    // log("category  = ${category}");
                    if (category != null) {
                      if (category == TimeCategory.normal) {
                        mode = RangeSelectionMode.toggledOff;
                        return CalendarComponent(
                          rangeSelectionMode: mode,
                        );
                      } else if (category == TimeCategory.period) {
                        mode = RangeSelectionMode.toggledOn;
                        return CalendarComponent(
                          rangeSelectionMode: mode,
                        );
                      } else if (category == TimeCategory.iterate) {
                        return const _IterateComponent();
                      }
                    }
                    return Container();
                  },
                ),
              ),
            ],
          )),
    );
  }
}

final selectIterateTypeProvider =
    StateProvider.autoDispose<IterateType?>((i) => null);
final timeCategoryProvider =
    StateProvider.autoDispose<TimeCategory?>((ref) => null);

class _IterateComponent extends ConsumerStatefulWidget {
  const _IterateComponent({super.key});

  @override
  ConsumerState<_IterateComponent> createState() => _IterateComponentState();
}

class _IterateComponentState extends ConsumerState<_IterateComponent>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((e) {
      ref
          .read(tgDateTimeFormProvider.notifier)
          .update(flowType: TriggerType.DayOfWeekTrigger);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final type = ref.watch(selectIterateTypeProvider);
    final chips = IterateType.values
        .map((i) => _IterateChip(
              selected: type == i,
              type: i,
              onTap: () {
                if (i == IterateType.week) {
                  ref
                      .read(tgDateTimeFormProvider.notifier)
                      .update(flowType: TriggerType.DayOfWeekTrigger);
                } else {
                  ref
                      .read(tgDateTimeFormProvider.notifier)
                      .update(flowType: TriggerType.DayOfMonthTrigger);
                }

                ref.read(selectIterateTypeProvider.notifier).update((s) => i);
              },
            ))
        .toList();

    return Align(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [...chips],
          ),
          SizedBox(height: 24.h),
          if (type == IterateType.week) _IteratorDayOfWeekComponent(),
          if (type == IterateType.month) _IteratorDayOfMonthComponent(),
        ],
      ),
    );
  }
}

class _IteratorDayOfWeekComponent extends ConsumerWidget {
  const _IteratorDayOfWeekComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDays =
        ref.watch(tgDateTimeFormProvider.select((p) => p.daysOfWeek));

    final dayOfWeeks = DayOfWeek.values
        .map((d) => _DayOfWeekComponent(
              selected: selectedDays?.contains(d) ?? false,
              onTap: () {
                if (selectedDays?.contains(d) ?? false) {
                  selectedDays!.remove(d);
                  final temp = selectedDays.toList();
                  ref
                      .read(tgDateTimeFormProvider.notifier)
                      .update(dayOfWeek: temp);
                } else {
                  /// 선택된 날짜가 없는 경우
                  if (selectedDays == null) {
                    ref
                        .read(tgDateTimeFormProvider.notifier)
                        .update(dayOfWeek: [d]);
                  } else {
                    selectedDays.add(d);
                    final temp = selectedDays.toList();
                    ref
                        .read(tgDateTimeFormProvider.notifier)
                        .update(dayOfWeek: temp);
                  }
                }
              },
              dayOfWeek: d,
            ))
        .toList();
    return Align(
      alignment: const Alignment(0, -1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: dayOfWeeks,
      ),
    );
  }
}

class _IteratorDayOfMonthComponent extends ConsumerWidget {
  const _IteratorDayOfMonthComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dayOfMonth =
        ref.watch(tgDateTimeFormProvider.select((tg) => tg.dayOfMonth));

    final dayChips = List.generate(
        31,
        (idx) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: _DayChip(
              day: 1 + idx,
              selected: dayOfMonth?.contains(1 + idx) ?? false,
              onTap: () {
                if (dayOfMonth?.contains(1 + idx) ?? false) {
                  dayOfMonth!.remove(1 + idx);
                  final temp = dayOfMonth.toList();
                  ref
                      .read(tgDateTimeFormProvider.notifier)
                      .update(dayOfMonth: temp);
                } else {
                  /// 선택된 날짜가 없는 경우
                  if (dayOfMonth == null) {
                    ref
                        .read(tgDateTimeFormProvider.notifier)
                        .update(dayOfMonth: [1 + idx]);
                  } else {
                    dayOfMonth.add(1 + idx);
                    final temp = dayOfMonth.toList();
                    ref
                        .read(tgDateTimeFormProvider.notifier)
                        .update(dayOfMonth: temp);
                  }
                }
              },
            )));

    return Padding(
      padding: EdgeInsets.all(12.r),
      child: Wrap(
        runSpacing: 8.h,
        children: dayChips,
      ),
    );
  }
}

class _DayChip extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  final int day;

  const _DayChip(
      {super.key,
      required this.day,
      required this.selected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                selected ? const Color(0xFFa3c9ff) : const Color(0xFFe4ecf9)),
        child: Text(
          "$day",
          style: SHFlowTextStyle.labelBold,
        ),
      ),
    );
  }
}

class _DayOfWeekComponent extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  final DayOfWeek dayOfWeek;

  const _DayOfWeekComponent(
      {super.key,
      required this.selected,
      required this.onTap,
      required this.dayOfWeek});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
            border: const Border(
              bottom: BorderSide(
                color: Color(0xFFEEEEEE),
              ),
            ),
            color: selected
                ? const Color(0xFF3F73FF).withOpacity(.15)
                : const Color(0x0fffffff)),
        child: Text(
          '${dayOfWeek.name}요일 마다',
          style: SHFlowTextStyle.subTitle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _TimeCategoryComponent extends ConsumerWidget {
  const _TimeCategoryComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(timeCategoryProvider, (previous, next) {
      TriggerType? type;
      if (next != null) {
        switch (next) {
          case TimeCategory.normal:
            type = TriggerType.SpecificDateTrigger;
            break;
          case TimeCategory.period:
            type = TriggerType.PeriodDateTrigger;
            break;
          case TimeCategory.iterate:
            // type = FlowType.;
            break;
        }
      }
      ref.read(tgDateTimeFormProvider.notifier).update(flowType: type);
    });

    final flowType = ref.watch(timeCategoryProvider);
    final chips = TimeCategory.values
        .map((t) => _DateTimeTriggerChip(
              selected: flowType == t,
              type: t,
              onTap: () {
                ref.read(timeCategoryProvider.notifier).update((tc) => t);
              },
            ))
        .toList();

    String title = "어떤조건을 확인할까요?";

    // if (flowType != null) {
    //   switch (flowType) {
    //     case TimeCategory.normal:
    //       title = '조건의 시간과 특정 날짜를 선택해보세요!';
    //       break;
    //     case TimeCategory.period:
    //       title = '조건의 시간과 기간을 선택해보세요!';
    //       break;
    //     case TimeCategory.iterate:
    //       title = '조건을 반복하고 싶은\n시간과 날짜 또는 요일을 선택해보세요!';
    //       break;
    //     // case TimeCategory.multi:
    //     //   title = '트리거의 여러 날짜를 선택해보세요!';
    //     //   break;
    //   }
    // }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: SHFlowTextStyle.subTitle,
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: chips,
          ),
        ],
      ),
    );
  }
}

//일반 기간 다중 반복
class _DateTimeTriggerChip extends StatelessWidget {
  final TimeCategory type;
  final bool selected;
  final VoidCallback onTap;

  const _DateTimeTriggerChip(
      {super.key,
      required this.selected,
      required this.type,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            color:
                selected ? const Color(0xFFa3c9ff) : const Color(0xFFD9D9D9)),
        padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 8.h),
        child: Text(
          type.name,
          style: SHFlowTextStyle.labelBold,
        ),
      ),
    );
  }
}

enum IterateType {
  week('매주'),
  month('매달');

  final String name;

  const IterateType(this.name);
}

//일반 기간 다중 반복
class _IterateChip extends StatelessWidget {
  final IterateType type;
  final bool selected;
  final VoidCallback onTap;

  const _IterateChip(
      {super.key,
      required this.selected,
      required this.type,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            color:
                selected ? const Color(0xFFa3c9ff) : const Color(0xFFD9D9D9)),
        padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 8.h),
        child: Text(
          type.name,
          style: SHFlowTextStyle.labelBold,
        ),
      ),
    );
  }
}
