import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shinhan_flow/auth/view/login_screen.dart';
import 'package:shinhan_flow/common/component/default_appbar.dart';
import 'package:shinhan_flow/common/component/default_text_button.dart';
import 'package:shinhan_flow/flow/model/enum/action_category.dart';
import 'package:shinhan_flow/flow/model/enum/trigger_category.dart';
import 'package:shinhan_flow/flow/model/enum/widget/flow_property.dart';
import 'package:shinhan_flow/flow/provider/trigger_category_provider.dart';
import 'package:shinhan_flow/flow/provider/widget/flow_form_provider.dart';
import 'package:shinhan_flow/trigger/view/account_trigger_screen.dart';
import 'package:shinhan_flow/trigger/view/time_trigger_screen.dart';
import 'package:shinhan_flow/theme/text_theme.dart';

class FlowInitScreen extends StatelessWidget {
  static String get routeName => 'flowInit';

  const FlowInitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (_, __) {
            return [
              const DefaultAppBar(
                isSliver: true,
                title: 'Flow 생성',
              )
            ];
          },
          body: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 28.h),
                sliver: SliverMainAxisGroup(slivers: [
                  SliverToBoxAdapter(
                    child: _TriggerComponent(
                      property: FlowProperty.trigger,
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 40.h)),
                  SliverToBoxAdapter(
                    child: _TriggerComponent(
                      property: FlowProperty.action,
                    ),
                  ),
                ]),
              ),
            ],
          )),
    );
  }
}

class _ActionComponent extends StatelessWidget {
  const _ActionComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _TriggerComponent extends ConsumerWidget {
  final FlowProperty property;

  const _TriggerComponent({
    super.key,
    required this.property,
  });

  Widget getTriggerAddBtn(
      BuildContext context, Set<TriggerCategoryType> triggers, WidgetRef ref) {
    return _AddButton(
      onTap: () {
        Set<TriggerCategoryType> tempSelected = {};
        showModalBottomSheet(
            showDragHandle: true,
            isScrollControlled: true,
            context: context,
            builder: (_) {
              final unSelectedTriggers = TriggerCategoryType.values.toList()
                ..removeWhere((t) => triggers.contains(t));
              final cards = unSelectedTriggers
                  .map((t) => _FlowInitCard(
                        triggerType: t,
                        onTap: () {
                          if (!tempSelected.add(t)) {
                            tempSelected.remove(t);
                          }
                        },
                      ))
                  .toList();

              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "추가로 선택하실 조건은 무엇인가요?",
                        style: SHFlowTextStyle.subTitle,
                      ),
                      SizedBox(height: 20.h),
                      ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, idx) {
                            return _FlowInitCard(
                              triggerType: unSelectedTriggers[idx],
                              onTap: () {
                                setState(() {
                                  if (!tempSelected
                                      .add(unSelectedTriggers[idx])) {
                                    tempSelected
                                        .remove(unSelectedTriggers[idx]);
                                  }
                                });
                              },
                              isSelected: tempSelected
                                  .contains(unSelectedTriggers[idx]),
                            );
                          },
                          separatorBuilder: (_, idx) => SizedBox(height: 12.h),
                          itemCount: cards.length),
                      SizedBox(height: 20.h),
                      Align(
                        child: DefaultTextButton(
                          onPressed: tempSelected.isNotEmpty
                              ? () {
                                  triggers.addAll(tempSelected);
                                  final newTriggers = triggers.toSet();

                                  ref
                                      .read(triggerCategoryProvider.notifier)
                                      .update((t) => newTriggers);
                                  context.pop();
                                }
                              : null,
                          text: "선택 완료",
                          able: tempSelected.isNotEmpty,
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                );
              });
            });
      },
    );
  }

  Widget getActionAddBtn(
      BuildContext context, Set<ActionCategoryType> triggers, WidgetRef ref) {
    return _AddButton(
      onTap: () {
        Set<ActionCategoryType> tempSelected = {};
        showModalBottomSheet(
            showDragHandle: true,
            isScrollControlled: true,
            context: context,
            builder: (_) {
              final unSelectedTriggers = ActionCategoryType.values.toList()
                ..removeWhere((t) => triggers.contains(t));
              final cards = unSelectedTriggers
                  .map((t) => _FlowInitCard(
                        actionType: t,
                        onTap: () {
                          if (!tempSelected.add(t)) {
                            tempSelected.remove(t);
                          }
                        },
                      ))
                  .toList();

              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "추가로 선택하실 조건은 무엇인가요?",
                        style: SHFlowTextStyle.subTitle,
                      ),
                      SizedBox(height: 20.h),
                      ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, idx) {
                            return _FlowInitCard(
                              actionType: unSelectedTriggers[idx],
                              onTap: () {
                                setState(() {
                                  if (!tempSelected
                                      .add(unSelectedTriggers[idx])) {
                                    tempSelected
                                        .remove(unSelectedTriggers[idx]);
                                  }
                                });
                              },
                              isSelected: tempSelected
                                  .contains(unSelectedTriggers[idx]),
                            );
                          },
                          separatorBuilder: (_, idx) => SizedBox(height: 12.h),
                          itemCount: cards.length),
                      SizedBox(height: 20.h),
                      Align(
                        child: DefaultTextButton(
                          onPressed: tempSelected.isNotEmpty
                              ? () {
                                  triggers.addAll(tempSelected);
                                  final newTriggers = triggers.toSet();

                                  ref
                                      .read(actionCategoryProvider.notifier)
                                      .update((t) => newTriggers);
                                  context.pop();
                                }
                              : null,
                          text: "선택 완료",
                          able: tempSelected.isNotEmpty,
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                );
              });
            });
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visibleDelete = ref.watch(showFlowDeleteProvider(property));
    final triggers = property == FlowProperty.trigger
        ? ref.watch(triggerCategoryProvider)
        : ref.watch(actionCategoryProvider);

    late final List<_FlowInitCard> cards;

    if (property == FlowProperty.trigger) {
      triggers as Set<TriggerCategoryType>;
      cards = triggers
          .map((t) => _FlowInitCard(
                triggerType: t,
                onTap: () {
                  if (TriggerCategoryType.time == t) {
                    context.pushNamed(TimeTriggerScreen.routeName);
                  } else if (TriggerCategoryType.transfer == t) {
                    context.pushNamed(AccountTriggerScreen.routeName);
                  } else if (TriggerCategoryType.exchange == t) {
                  } else {}
                },
                visibleDelete: visibleDelete,
              ))
          .toList();
    } else {
      triggers as Set<ActionCategoryType>;
      cards = triggers
          .map((t) => _FlowInitCard(
                actionType: t,
                onTap: () {
                  if (ActionCategoryType.notification == t) {
                  } else if (ActionCategoryType.exchange == t) {
                  } else {}
                },
                visibleDelete: visibleDelete,
              ))
          .toList();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              property == FlowProperty.trigger ? '조건' : '행동',
              style: SHFlowTextStyle.subTitle,
            ),
            InkWell(
              onTap: () {
                ref
                    .read(showFlowDeleteProvider(property).notifier)
                    .update((s) => !s);
              },
              child: Icon(
                Icons.delete,
                color: visibleDelete ? const Color(0xFF0057FF) : Colors.black,
              ),
            )
          ],
        ),
        SizedBox(height: 12.h),
        ListView.separated(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, idx) => cards[idx],
          separatorBuilder: (_, idx) => SizedBox(height: 12.h),
          itemCount: cards.length,
        ),
        if (cards.length != 4 && property == FlowProperty.trigger)
          getTriggerAddBtn(context, triggers as Set<TriggerCategoryType>, ref),
        if (cards.length != 3 && property == FlowProperty.action)
          getActionAddBtn(context, triggers as Set<ActionCategoryType>, ref)
        // _AddButton(
        //   onTap: () {
        //     Set<TriggerCategoryType> tempSelected = {};
        //     showModalBottomSheet(
        //         showDragHandle: true,
        //         isScrollControlled: true,
        //         context: context,
        //         builder: (_) {
        //           final unSelectedTriggers = TriggerCategoryType.values
        //               .toList()
        //             ..removeWhere((t) => triggers.contains(t));
        //           final cards = unSelectedTriggers
        //               .map((t) => _FlowInitCard(
        //                     triggerType: t,
        //                     onTap: () {
        //                       if (!tempSelected.add(t)) {
        //                         tempSelected.remove(t);
        //                       }
        //                     },
        //                   ))
        //               .toList();
        //
        //           return StatefulBuilder(
        //               builder: (BuildContext context, StateSetter setState) {
        //             return Padding(
        //               padding: EdgeInsets.symmetric(
        //                 horizontal: 20.w,
        //               ),
        //               child: Column(
        //                 mainAxisSize: MainAxisSize.min,
        //                 crossAxisAlignment: CrossAxisAlignment.stretch,
        //                 children: [
        //                   Text(
        //                     "추가로 선택하실 조건은 무엇인가요?",
        //                     style: SHFlowTextStyle.subTitle,
        //                   ),
        //                   SizedBox(height: 20.h),
        //                   ListView.separated(
        //                       shrinkWrap: true,
        //                       padding: EdgeInsets.zero,
        //                       physics: const NeverScrollableScrollPhysics(),
        //                       itemBuilder: (_, idx) {
        //                         return _FlowInitCard(
        //                           triggerType: unSelectedTriggers[idx],
        //                           onTap: () {
        //                             setState(() {
        //                               if (!tempSelected
        //                                   .add(unSelectedTriggers[idx])) {
        //                                 tempSelected
        //                                     .remove(unSelectedTriggers[idx]);
        //                               }
        //                             });
        //                           },
        //                           isSelected: tempSelected
        //                               .contains(unSelectedTriggers[idx]),
        //                         );
        //                       },
        //                       separatorBuilder: (_, idx) =>
        //                           SizedBox(height: 12.h),
        //                       itemCount: cards.length),
        //                   SizedBox(height: 20.h),
        //                   Align(
        //                     child: DefaultTextButton(
        //                       onPressed: tempSelected.isNotEmpty
        //                           ? () {
        //                               triggers.addAll(tempSelected);
        //                               final newTriggers = triggers.toSet();
        //
        //                               ref
        //                                   .read(triggerCategoryProvider
        //                                       .notifier)
        //                                   .update((t) => newTriggers);
        //                               context.pop();
        //                             }
        //                           : null,
        //                       text: "선택 완료",
        //                       able: tempSelected.isNotEmpty,
        //                     ),
        //                   ),
        //                   SizedBox(height: 20.h),
        //                 ],
        //               ),
        //             );
        //           });
        //         });
        //   },
        // ),
      ],
    );
  }
}

class _FlowInitCard extends ConsumerWidget {
  final VoidCallback onTap;
  final TriggerCategoryType? triggerType;
  final ActionCategoryType? actionType;
  final bool visibleDelete;
  final bool isSelected;

  const _FlowInitCard(
      {super.key,
      this.triggerType,
      this.actionType,
      required this.onTap,
      this.isSelected = false,
      this.visibleDelete = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(Size(double.infinity, 100.h)),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: InkWell(
              onTap: onTap,
              child: Align(
                child: Container(
                  width: double.infinity,
                  height: 90.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: isSelected
                          ? const Color(0xFF0057FF)
                          : const Color(0xFFa3c9ff)),
                  alignment: Alignment.center,
                  child: Text(
                    triggerType != null
                        ? '${triggerType!.name} 조건 선택'
                        : '${actionType!.name} 하기',
                    style: SHFlowTextStyle.subTitle.copyWith(
                        color: isSelected ? Colors.white : Colors.black),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: visibleDelete,
            child: Positioned(
              top: 0,
              right: 0,
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return InkWell(
                    onTap: () {
                      if (triggerType != null) {
                        final triggers = ref.read(triggerCategoryProvider);
                        triggers.remove(triggerType);
                        ref
                            .read(triggerCategoryProvider.notifier)
                            .update((t) => triggers.toSet());
                      } else {
                        final triggers = ref.read(actionCategoryProvider);
                        triggers.remove(actionType);
                        ref
                            .read(actionCategoryProvider.notifier)
                            .update((t) => triggers.toSet());
                      }
                    },
                    child: child!,
                  );
                },
                child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: Offset(2.r, 2.r),
                          )
                        ]),
                    child: const Icon(Icons.close)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AddButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 58.h,
        margin: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: const Color(0xFFededed),
        ),
        child: Icon(
          Icons.add,
          size: 32.r,
        ),
      ),
    );
  }
}
