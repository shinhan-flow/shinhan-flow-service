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
import 'package:shinhan_flow/flow/provider/widget/flow_form_provider.dart';
import 'package:shinhan_flow/flow/provider/widget/time_form_provider.dart';
import 'package:shinhan_flow/theme/text_theme.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../common/component/default_text_button.dart';
import '../../common/component/table_calendar.dart';
import '../../flow/param/enum/flow_type.dart';
import '../../flow/param/trigger/trigger_param.dart';
import '../model/enum/time_category.dart';

class TimeTriggerScreen extends StatelessWidget {
  static String get routeName => 'timeTrigger';

  const TimeTriggerScreen({super.key});

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
                          trigger: trigger.toParam() as TriggerParam);
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
                title: '시간 조건 설정',
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
              )
            ],
          )),
    );
  }
}

final timeCategoryProvider =
    StateProvider.autoDispose<TimeCategory?>((ref) => null);

class _IterateComponent extends ConsumerStatefulWidget {
  const _IterateComponent({super.key});

  @override
  ConsumerState<_IterateComponent> createState() => _IterateComponentState();
}

class _IterateComponentState extends ConsumerState<_IterateComponent>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        changeFlowType();
      });
    WidgetsBinding.instance.addPostFrameCallback((e) {
      ref
          .read(tgDateTimeFormProvider.notifier)
          .update(flowType: FlowType.dayOfWeek);
    });
  }

  void changeFlowType() {
    log("tabController.index ${tabController.index}");
    int idx = tabController.index;
    ref
        .read(tgDateTimeFormProvider.notifier)
        .update(flowType: idx == 0 ? FlowType.dayOfWeek : FlowType.dayOfMonth);
  }

  @override
  void dispose() {
    tabController.removeListener(() => changeFlowType());
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final flowType =
    //     ref.watch(tgDateTimeFormProvider.select((tg) => tg.flowType));
    SchedulerBinding.instance.addPostFrameCallback((v) {});
    // CustomSingleChildLayout(delegate: null,);
    return Align(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 24.w),
          //   child: Text(
          //     '트리거를 반복하고 싶은\n날짜 또는 요일을 선택해보세요!',
          //     style: SHFlowTextStyle.subTitle,
          //   ),
          // ),
          SizedBox(height: 12.h),
          Expanded(
            child: NestedScrollView(
              physics: const NeverScrollableScrollPhysics(),
              headerSliverBuilder: (_, __) {
                return [
                  SliverPersistentHeader(
                    delegate: _SliverAppBarDelegate(TabBar(
                      indicatorWeight: 1.w,
                      unselectedLabelColor: const Color(0xFFaFaFAF),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelStyle: SHFlowTextStyle.form,
                      controller: tabController,
                      dividerColor: const Color(0xFFaFaFAF),
                      onTap: (idx) {
                        tabController.animateTo(idx);
                      },
                      tabs: const [
                        Tab(child: Text('날짜 선택')),
                        Tab(child: Text('요일 선택')),
                      ],
                    )),
                    pinned: true,
                  ),
                ];
              },
              body: CustomScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  slivers: [
                    SliverFillRemaining(
                      child: TabBarView(controller: tabController, children: [
                        _IteratorDayOfWeekComponent(),
                        _IteratorDayOfMonthComponent(),
                      ]),
                    ),
                  ]),
            ),
          ),
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
        ref.watch(tgDateTimeFormProvider.select((p) => p.dayOfWeek));

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
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Wrap(
          spacing: 16.w,
          children: dayOfWeeks,
        ),
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
    return InkWell(
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
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                selected ? const Color(0xFFa3c9ff) : const Color(0xFFe4ecf9)),
        child: Text(
          dayOfWeek.name,
          style: SHFlowTextStyle.labelBold,
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
      FlowType? type;
      if (next != null) {
        switch (next) {
          case TimeCategory.normal:
            type = FlowType.specificDate;
            break;
          case TimeCategory.period:
            type = FlowType.periodDate;
            break;
          case TimeCategory.iterate:
            // type = FlowType.;
            break;
          // case TimeCategory.multi:
          //   type = FlowType.multiDate;
          //   break;
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
    String title = "시간 조건을 선택하여\n나만의 플로우를 시작해보세요!";

    if (flowType != null) {
      switch (flowType) {
        case TimeCategory.normal:
          title = '트리거의 특정 날짜를 선택해보세요!';
          break;
        case TimeCategory.period:
          title = '트리거의 기간을 선택해보세요!';
          break;
        case TimeCategory.iterate:
          title = '트리거를 반복하고 싶은\n날짜 또는 요일을 선택해보세요!';
          break;
        // case TimeCategory.multi:
        //   title = '트리거의 여러 날짜를 선택해보세요!';
        //   break;
      }
    }

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
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            color:
                selected ? const Color(0xFFa3c9ff) : const Color(0xFFe4ecf9)),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: Text(
          type.name,
          style: SHFlowTextStyle.labelBold,
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(
    this._tabBar,
  );

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
