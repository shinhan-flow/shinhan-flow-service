import 'dart:developer';

import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shinhan_flow/account/view/account_transfer_screen.dart';
import 'package:shinhan_flow/action/param/action_balance_notification_param.dart';
import 'package:shinhan_flow/action/param/action_exchange_param.dart';
import 'package:shinhan_flow/action/param/action_exchange_rate_notification_param.dart';
import 'package:shinhan_flow/action/param/action_text_notification_param.dart';
import 'package:shinhan_flow/common/component/default_appbar.dart';
import 'package:shinhan_flow/common/component/default_flashbar.dart';
import 'package:shinhan_flow/common/component/default_text_button.dart';
import 'package:shinhan_flow/common/component/time_picker.dart';
import 'package:shinhan_flow/common/model/default_model.dart';
import 'package:shinhan_flow/flow/model/enum/action_category.dart';
import 'package:shinhan_flow/flow/model/enum/trigger_category.dart';
import 'package:shinhan_flow/flow/model/enum/widget/flow_property.dart';
import 'package:shinhan_flow/flow/param/enum/flow_type.dart';
import 'package:shinhan_flow/flow/param/trigger/account/trigger_balance_account_param.dart';
import 'package:shinhan_flow/flow/param/trigger/account/trigger_deposit_account_param.dart';
import 'package:shinhan_flow/flow/param/trigger/account/trigger_transfer_account_param.dart';
import 'package:shinhan_flow/flow/param/trigger/account/trigger_withdraw_account_param.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_product_param.dart';
import 'package:shinhan_flow/flow/provider/flow_provider.dart';
import 'package:shinhan_flow/flow/provider/widget/time_form_provider.dart';
import 'package:shinhan_flow/flow/provider/widget/trigger_category_provider.dart';
import 'package:shinhan_flow/flow/provider/widget/flow_form_provider.dart';
import 'package:shinhan_flow/home_screen.dart';
import 'package:shinhan_flow/trigger/model/enum/product_property.dart';
import 'package:shinhan_flow/trigger/view/account_trigger_screen.dart';
import 'package:shinhan_flow/trigger/view/time_trigger_screen.dart';
import 'package:shinhan_flow/theme/text_theme.dart';

import '../../action/model/enum/action_type.dart';
import '../../action/param/action_transfer_param.dart';
import '../../action/view/action_exchange_screen.dart';
import '../../action/view/action_notification_screen.dart';
import '../../action/view/action_transfer_screen.dart';
import '../../common/component/bottom_nav_button.dart';
import '../../trigger/view/exchange_trigger_screen.dart';
import '../../trigger/view/product_trigger_screen.dart';
import '../model/flow_model.dart';
import '../param/trigger/trigger_date_time_param.dart';
import '../param/trigger/trigger_exchange_param.dart';
import '../param/trigger/trigger_param.dart';
import 'package:collection/collection.dart';

import 'flow_detail_screen.dart';

final flowIdProvider = StateProvider.autoDispose<int?>((ref) => null);

class FlowInitScreen extends ConsumerStatefulWidget {
  static String get routeName => 'flowInit';

  const FlowInitScreen({
    super.key,
  });

  @override
  ConsumerState<FlowInitScreen> createState() => _FlowInitScreenState();
}

class _FlowInitScreenState extends ConsumerState<FlowInitScreen> {
  @override
  void initState() {
    super.initState();
    final flowId = ref.read(flowIdProvider);
    if (flowId != null) {
      WidgetsBinding.instance.addPostFrameCallback((t) {
        final result = ref.read(flowDetailProvider(id: flowId));
        final model = (result as ResponseModel<FlowDetailModel>).data!;
        ref.read(flowFormProvider.notifier).update(
              title: model.title,
              description: model.description,
              triggers: model.triggers.toList(),
              actions: model.actions.toList(),
            );
      });
    }
  }

  bool validDate(String date) {
    final now = DateTime.now();

    log('now  = $now date = $date');
    return now.compareTo(DateTime.parse(date)) == -1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final valid = ref.watch(flowFormProvider).valid;
          return BottomNavButton(
              child: DefaultTextButton(
            onPressed: () async {
              final dateTimeTriggers = ref
                  .read(flowFormProvider)
                  .triggers
                  .where((t) => t.type.isTimeType() || t.type.isDateType())
                  .toList();
              String date = '';
              String time = '00:00:00';
              bool timeValid = true;
              for (var t in dateTimeTriggers) {
                // 1. 날짜 검증, 2. 시간 검증
                // 날짜 fail => fail
                // 날짜 pass => 시간 fail => fail
                // 날짜 pass => 시간 pass => pass
                /// 시간 먼저 검증
                DateTime now = DateTime.now();
                final df = DateFormat('yyyy-MM-dd');
                if (t.type != TriggerType.SpecificTimeTrigger) {
                  if (t is TgSpecificDateParam) {
                    date = t.localDate!;
                  } else if (t is TgPeriodDateParam) {
                    date = t.startDate!;
                  } else if (t is TgDayOfWeekParam) {
                    date = '9999-01-01';
                  } else if (t is TgDayOfMonthParam) {
                    date = '9999-01-01';
                  }
                } else {
                  final param = t as TgTimeParam;
                  time = param.time;
                }
              }
              if (date.isNotEmpty) {
                timeValid = validDate("$date $time");
              }

              if (timeValid) {
                final result = await ref.read(createFlowProvider.future);
                if (result is ErrorModel) {
                } else {
                  if (context.mounted) {
                    context.goNamed(HomeScreen.routeName);
                    FlashUtil.showFlash(context, '플로우 생성 성공!',
                        textColor: const Color(0xFF49B7FF));
                  }
                }
              } else {
                FlashUtil.showFlash(
                  context,
                  '날짜 및 시간이 현재 이후 이어야 합니다!',
                  textColor: const Color(0xFFe21a1a),
                );
              }
            },
            text: '생성하기',
            able: valid,
          ));
        },
      ),
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
                    child: _FlowInitComponent(
                      property: FlowProperty.trigger,
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 40.h)),
                  SliverToBoxAdapter(
                    child: _FlowInitComponent(
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

class _FlowInitComponent extends ConsumerWidget {
  final FlowProperty property;

  const _FlowInitComponent({
    super.key,
    required this.property,
  });

  Widget getTriggerAddBtn(
      BuildContext context, List<TriggerBaseParam> triggers, WidgetRef ref) {
    return _AddButton(
      onTap: () {
        Set<TriggerCategoryType> tempSelected = {};
        showModalBottomSheet(
            showDragHandle: true,
            isScrollControlled: true,
            context: context,
            builder: (_) {
              final date =
                  triggers.firstWhereOrNull((t) => t.type.isDateType());
              final time =
                  triggers.firstWhereOrNull((t) => t.type.isTimeType());
              final product =
                  triggers.firstWhereOrNull((t) => t.type.isProductType());
              final exchange =
                  triggers.firstWhereOrNull((t) => t.type.isExchangeType());
              final account =
                  triggers.firstWhereOrNull((t) => t.type.isAccountType());

              final List<TriggerCategoryType> unSelected = [];
              if (date == null) {
                unSelected.add(TriggerCategoryType.date);
              }
              if (time == null) {
                unSelected.add(TriggerCategoryType.time);
              }
              if (product == null) {
                unSelected.add(TriggerCategoryType.product);
              }
              if (exchange == null) {
                unSelected.add(TriggerCategoryType.exchange);
              }
              if (account == null) {
                unSelected.add(TriggerCategoryType.transfer);
              }

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
                              triggerType: unSelected[idx],
                              onTap: () {
                                context.pop();
                                if (unSelected[idx] ==
                                    TriggerCategoryType.date) {
                                  context
                                      .pushNamed(TimeTriggerScreen.routeName);
                                } else if (unSelected[idx] ==
                                    TriggerCategoryType.time) {
                                  context
                                      .pushNamed(TimeTriggerScreen.routeName);
                                } else if (unSelected[idx] ==
                                    TriggerCategoryType.exchange) {
                                  context.pushNamed(
                                      ExchangeTriggerScreen.routeName);
                                } else if (unSelected[idx] ==
                                    TriggerCategoryType.product) {
                                  context.pushNamed(
                                      ProductTriggerScreen.routeName);
                                } else if (unSelected[idx] ==
                                    TriggerCategoryType.transfer) {
                                  context.pushNamed(
                                      AccountTriggerScreen.routeName);
                                }
                              },
                              // isSelected: tempSelected
                              //     .contains(unSelectedTriggers[idx]),
                            );
                          },
                          separatorBuilder: (_, idx) => SizedBox(height: 12.h),
                          itemCount: unSelected.length),
                      SizedBox(height: 20.h),
                      Align(
                        child: DefaultTextButton(
                          onPressed: tempSelected.isNotEmpty
                              ? () {
                                  // triggers.addAll(tempSelected);
                                  // final newTriggers = triggers.toSet();
                                  //
                                  // ref
                                  //     .read(triggerCategoryProvider.notifier)
                                  //     .update((t) => newTriggers);
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
      BuildContext context, List<ActionBaseParam> actions, WidgetRef ref) {
    return _AddButton(
      onTap: () {
        Set<ActionCategoryType> tempSelected = {};
        showModalBottomSheet(
            showDragHandle: true,
            isScrollControlled: true,
            context: context,
            builder: (_) {
              final exchange =
                  actions.firstWhereOrNull((t) => t.type.isExchangeType());
              final notification =
                  actions.firstWhereOrNull((t) => t.type.isNotificationType());
              final transfer =
                  actions.firstWhereOrNull((t) => t.type.isTransferType());

              final List<ActionCategoryType> unSelected = [];
              if (exchange == null) {
                unSelected.add(ActionCategoryType.exchange);
              }
              if (notification == null) {
                unSelected.add(ActionCategoryType.notification);
              }
              if (transfer == null) {
                unSelected.add(ActionCategoryType.transfer);
              }

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
                              actionType: unSelected[idx],
                              onTap: () {
                                context.pop();
                                if (unSelected[idx] ==
                                    ActionCategoryType.transfer) {
                                  context.pushNamed(
                                      ActionExchangeScreen.routeName);
                                } else if (unSelected[idx] ==
                                    ActionCategoryType.notification) {
                                  context.pushNamed(
                                      ActionNotificationScreen.routeName);
                                } else if (unSelected[idx] ==
                                    ActionCategoryType.exchange) {
                                  context.pushNamed(
                                      ActionTransferScreen.routeName);
                                }
                              },
                              // isSelected: tempSelected
                              //     .contains(unSelectedTriggers[idx]),
                            );
                          },
                          separatorBuilder: (_, idx) => SizedBox(height: 12.h),
                          itemCount: unSelected.length),
                      SizedBox(height: 20.h),
                      Align(
                        child: DefaultTextButton(
                          onPressed: tempSelected.isNotEmpty
                              ? () {
                                  // triggers.addAll(tempSelected);
                                  // final newTriggers = triggers.toSet();
                                  //
                                  // ref
                                  //     .read(triggerCategoryProvider.notifier)
                                  //     .update((t) => newTriggers);
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
    final flowId = ref.watch(flowIdProvider);

    final visibleDelete = ref.watch(showFlowDeleteProvider(property));
    final triggers = property == FlowProperty.trigger
        ? ref.watch(triggerCategoryProvider)
        : ref.watch(actionCategoryProvider);

    final form = ref.watch(flowFormProvider);

    /// 트리거 모으기
    final timeTrigger =
        form.triggers.firstWhereOrNull((t) => t.type.isTimeType());
    final productTrigger =
        form.triggers.firstWhereOrNull((t) => t.type.isProductType());
    final accountTrigger =
        form.triggers.firstWhereOrNull((t) => t.type.isAccountType());
    final exchangeTrigger =
        form.triggers.firstWhereOrNull((t) => t.type.isExchangeType());
    final dateTrigger =
        form.triggers.firstWhereOrNull((t) => t.type.isDateType());

    /// 액션 모으기
    final transferAction =
        form.actions.firstWhereOrNull((t) => t.type.isTransferType());
    final exchangeAction =
        form.actions.firstWhereOrNull((t) => t.type.isExchangeType());
    final notificationAction =
        form.actions.firstWhereOrNull((t) => t.type.isNotificationType());
    final formTriggers = [
      dateTrigger,
      timeTrigger,
      productTrigger,
      accountTrigger,
      exchangeTrigger
    ];
    final formActions = [
      transferAction,
      exchangeAction,
      notificationAction,
    ];

    late final List<_FlowInitCard> cards;
    List<GestureDetector> tCards = [];
    List<GestureDetector> aCards = [];
    if (property == FlowProperty.trigger) {
      // 트리거 카드 주입
      tCards = formTriggers
          .where((t) => t != null)
          .map((t) => GestureDetector(
                onTap: () {
                  if (t.type.isTimeType() || t.type.isDateType()) {
                    context.pushNamed(TimeTriggerScreen.routeName);
                  } else if (t.type.isAccountType()) {
                    context.pushNamed(AccountTriggerScreen.routeName);
                  } else if (t.type.isExchangeType()) {
                    context.pushNamed(ExchangeTriggerScreen.routeName);
                  } else if (t.type.isProductType()) {
                    context.pushNamed(ProductTriggerScreen.routeName);
                  }
                },
                child: TriggerCard(
                  trigger: t!,
                  visibleDelete: visibleDelete,
                ),
              ))
          .toList();

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
                    context.pushNamed(ExchangeTriggerScreen.routeName);
                  } else {
                    context.pushNamed(ProductTriggerScreen.routeName);
                  }
                },
                visibleDelete: visibleDelete,
              ))
          .toList();
    } else {
      // 액션 카드 주입
      aCards = formActions
          .where((t) => t != null)
          .map((t) => GestureDetector(
                onTap: () {
                  if (t.type.isNotificationType()) {
                    context.pushNamed(ActionNotificationScreen.routeName);
                  } else if (t.type.isExchangeType()) {
                    context.pushNamed(ActionExchangeScreen.routeName);
                  } else {
                    context.pushNamed(ActionTransferScreen.routeName);
                  }
                },
                child: ActionCard(
                  action: t!,
                  visibleDelete: visibleDelete,
                ),
              ))
          .toList();

      triggers as Set<ActionCategoryType>;
      cards = triggers
          .map(
            (t) => _FlowInitCard(
              actionType: t,
              onTap: () {
                if (ActionCategoryType.notification == t) {
                  context.pushNamed(ActionNotificationScreen.routeName);
                } else if (ActionCategoryType.exchange == t) {
                  context.pushNamed(ActionExchangeScreen.routeName);
                } else {
                  context.pushNamed(ActionTransferScreen.routeName);
                }
              },
              visibleDelete: visibleDelete,
            ),
          )
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
            GestureDetector(
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
          itemBuilder: (_, idx) =>
              property == FlowProperty.trigger ? tCards[idx] : aCards[idx],
          separatorBuilder: (_, idx) => SizedBox(height: 12.h),
          itemCount:
              property == FlowProperty.trigger ? tCards.length : aCards.length,
        ),
        if (tCards.length != 4 && property == FlowProperty.trigger)
          getTriggerAddBtn(context, form.triggers, ref),
        if (aCards.length != 3 && property == FlowProperty.action)
          getActionAddBtn(context, form.actions, ref)
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
    String content = triggerType != null
        ? '${triggerType!.name} 조건 생성 하기'
        : '${actionType!.name} 액션 생성 하기';

    return ConstrainedBox(
      constraints: BoxConstraints.tight(Size(double.infinity, 100.h)),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: GestureDetector(
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
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
                  return GestureDetector(
                    onTap: () {
                      if (triggerType != null) {
                        final triggers = ref.read(triggerCategoryProvider);
                        triggers.remove(triggerType);
                        ref
                            .read(triggerCategoryProvider.notifier)
                            .update((t) => triggers.toSet());
                        // ref
                        //     .read(flowFormProvider.notifier)
                        //     .removeTrigger(trigger: triggerType!);
                      } else {
                        final triggers = ref.read(actionCategoryProvider);
                        triggers.remove(actionType);
                        ref
                            .read(actionCategoryProvider.notifier)
                            .update((t) => triggers.toSet());
                        // ref
                        //     .read(flowFormProvider.notifier)
                        //     .removeAction(action: actionType!);
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
