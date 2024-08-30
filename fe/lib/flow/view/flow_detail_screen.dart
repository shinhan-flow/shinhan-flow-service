import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shinhan_flow/account/provider/account_holder_provider.dart';
import 'package:shinhan_flow/action/param/action_balance_notification_param.dart';
import 'package:shinhan_flow/action/param/action_exchange_param.dart';
import 'package:shinhan_flow/action/param/action_exchange_rate_notification_param.dart';
import 'package:shinhan_flow/action/param/action_text_notification_param.dart';
import 'package:shinhan_flow/action/param/action_transfer_param.dart';
import 'package:shinhan_flow/common/component/bottom_nav_button.dart';
import 'package:shinhan_flow/common/component/default_appbar.dart';
import 'package:shinhan_flow/common/component/default_flashbar.dart';
import 'package:shinhan_flow/common/component/default_text_button.dart';
import 'package:shinhan_flow/common/model/default_model.dart';
import 'package:shinhan_flow/flow/model/flow_model.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_param.dart';
import 'package:shinhan_flow/flow/provider/flow_provider.dart';
import 'package:shinhan_flow/home_screen.dart';
import 'package:shinhan_flow/theme/text_theme.dart';

import '../../account/model/account_holder_model.dart';
import '../../action/model/enum/action_type.dart';
import '../../common/model/bank_model.dart';
import '../../util/util.dart';
import '../param/enum/flow_type.dart';
import '../param/trigger/account/trigger_balance_account_param.dart';
import '../param/trigger/account/trigger_deposit_account_param.dart';
import '../param/trigger/account/trigger_transfer_account_param.dart';
import '../param/trigger/account/trigger_withdraw_account_param.dart';
import '../param/trigger/trigger_date_time_param.dart';
import '../param/trigger/trigger_exchange_param.dart';
import '../param/trigger/trigger_product_param.dart';

class FlowDetailScreen extends ConsumerWidget {
  static String get routeName => 'flowDetail';
  final int flowId;

  const FlowDetailScreen({
    super.key,
    required this.flowId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(flowDetailProvider(id: flowId));
    if (result is LoadingModel) {
      return Scaffold(
        body: CircularProgressIndicator(),
      );
    } else if (result is ErrorModel) {
      return Scaffold(
        body: Text("error"),
      );
    }
    final model = (result as ResponseModel<FlowDetailModel>).data!;

    log('model = $model');
    return Scaffold(
      bottomNavigationBar: BottomNavButton(
          child: DefaultTextButton(
        fillColor: const Color(0xFFF3595B),
        // textColor: Colors.black,
        onPressed: () async {
          final result =
              await ref.read(deleteFlowProvider(flowId: flowId).future);
          if (result is ErrorModel) {
            FlashUtil.showFlash(
              context,
              '플로우 실패 성공!',
              textColor: const Color(0xFFE21A1A),
            );
          } else {
            if (context.mounted) {
              FlashUtil.showFlash(
                context,
                '플로우 삭제 성공!',
                textColor: const Color(0xFF49B7FF),
              );
              context.goNamed(HomeScreen.routeName);
            }
          }
        },
        text: '삭제하기',
        able: true,
      )),
      body: NestedScrollView(
        headerSliverBuilder: (_, __) {
          return [
            const DefaultAppBar(
              isSliver: true,
              title: '플로우 상세',
            )
          ];
        },
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _FlowDetailComponent.fromModel(model: model),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              sliver: SliverMainAxisGroup(slivers: [
                SliverToBoxAdapter(
                  child: Text(
                    "조건",
                    style: SHFlowTextStyle.subTitle,
                  ),
                ),
                SliverList.builder(
                  itemBuilder: (_, idx) {
                    return _TriggerCard(trigger: model.triggers[idx]);
                  },
                  itemCount: model.triggers.length,
                ),
              ]),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20.h,
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              sliver: SliverMainAxisGroup(slivers: [
                SliverToBoxAdapter(
                  child: Text(
                    "행동",
                    style: SHFlowTextStyle.subTitle,
                  ),
                ),
                SliverList.builder(
                  itemBuilder: (_, idx) {
                    return _ActionCard(
                      action: model.actions[idx],
                    );
                  },
                  itemCount: model.actions.length,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _FlowDetailComponent extends StatelessWidget {
  final String title;
  final String desc;

  const _FlowDetailComponent(
      {super.key, required this.title, required this.desc});

  factory _FlowDetailComponent.fromModel({required FlowDetailModel model}) {
    return _FlowDetailComponent(
      title: model.title,
      desc: model.description,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: SHFlowTextStyle.title,
          ),
          SizedBox(height: 12.h),
          Text(
            desc,
            style: SHFlowTextStyle.subTitle,
          ),
        ],
      ),
    );
  }
}

class _TriggerCard extends ConsumerWidget {
  final TriggerBaseParam trigger;

  const _TriggerCard({super.key, required this.trigger});

  Future<String> getContent(WidgetRef ref) async {
    switch (trigger.type) {
      case TriggerType.SpecificTimeTrigger:
        final model = trigger as TgTimeParam;
        final time = DateTime.parse('2024-01-01 ${model.time}');
        final content = DateFormat('hh 시 mm 분').format(time);
        return '$content 에';
      case TriggerType.BalanceTrigger:
        final model = trigger as TgAccountBalanceParam;
        final balance = FormatUtil.formatNumber(model.balance);
// log("AAA");
        final result = await ref
            .read(accountHolderProvider(accountNo: model.account).future);
        if (result is ErrorModel) {
          return 'balance error';
        } else {
          final userName =
              (result as ResponseModel<BankBaseModel<AccountHolderModel>>)
                  .data!
                  .rec
                  .userName;
          return '$userName에게$balance${model.condition.name}';
        }
      case TriggerType.DayOfMonthTrigger:
        final model = trigger as TgDayOfMonthParam;
        final dayOfWeek =
            model.days!.map((d) => d.toString()).reduce((v, e) => "$v, $e");
        return "매월 $dayOfWeek일 반복";
      case TriggerType.DayOfWeekTrigger:
        final model = trigger as TgDayOfWeekParam;
        final dayOfWeek =
            model.daysOfWeek!.map((d) => d.name).reduce((v, e) => "$v, $e");
        return "매주 $dayOfWeek 반복";
      case TriggerType.DepositTrigger:
        final model = trigger as TgAccountDepositParam;
        final balance = FormatUtil.formatNumber(model.amount);

        final result = await ref
            .read(accountHolderProvider(accountNo: model.account).future);
        if (result is ErrorModel) {
          return 'error';
        } else {
          final userName =
              (result as ResponseModel<BankBaseModel<AccountHolderModel>>)
                  .data!
                  .rec
                  .userName;
          return '$userName에게 $balance원이 입금 되면';
        }

      case TriggerType.ExchangeRateTrigger:
        final model = trigger as TgExchangeParam;
        final rate = FormatUtil.formatDouble(model.rate!);
        return '${model.currency!.displayName}이 환율 $rate원 이하일 때';
      case TriggerType.InterestRateTrigger:
        final model = trigger as TgProductParam;
        return '수시 입출금 이자율이 ${model.rate}% 이하일 때';
      case TriggerType.PeriodDateTrigger:
        final model = trigger as TgPeriodDateParam;
        final startDate = DateTime.parse(model.startDate!);
        final endDate = DateTime.parse(model.endDate!);
        final df = DateFormat('yyyy년 MM월 dd일');
        final start = df.format(startDate);
        final end = df.format(endDate);
        return '$start부터\n$end 동안';
      case TriggerType.SpecificDateTrigger:
        final model = trigger as TgSpecificDateParam;
        final date = DateTime.parse(model.localDate!);
        final content = DateFormat('yyyy년 MM월 dd일').format(date);
        return '$content';
      case TriggerType.TransferTrigger:
        final model = trigger as TgAccountTransferParam;
        final amount = FormatUtil.formatNumber(model.amount);
        String from = '';
        String to = '';
        final fromResult = await ref
            .read(accountHolderProvider(accountNo: model.fromAccount).future);
        if (fromResult is ErrorModel) {
          return 'balance error';
        } else {
          from =
              (fromResult as ResponseModel<BankBaseModel<AccountHolderModel>>)
                  .data!
                  .rec
                  .userName;
        }
        final toResult = await ref
            .read(accountHolderProvider(accountNo: model.toAccount).future);
        if (toResult is ErrorModel) {
          return 'balance error';
        } else {
          to = (toResult as ResponseModel<BankBaseModel<AccountHolderModel>>)
              .data!
              .rec
              .userName;
        }

        return '$from이 $to에게 $amount원 이체 되면';
      case TriggerType.WithDrawTrigger:
        final model = trigger as TgAccountWithdrawParam;
        final result = await ref
            .read(accountHolderProvider(accountNo: model.account).future);
        final amount = FormatUtil.formatNumber(model.amount);

        if (result is ErrorModel) {
          return 'error';
        } else {
          final userName =
              (result as ResponseModel<BankBaseModel<AccountHolderModel>>)
                  .data!
                  .rec
                  .userName;
          return '$userName에게 $amount원이 출금 되면';
        }
      // 다른 TriggerType에 대한 처리 추가
      default:
        throw Exception("Unknown TriggerType: ");
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: getContent(ref),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData == false) {
          return CircularProgressIndicator();
        }
        //error가 발생하게 될 경우 반환하게 되는 부분
        else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Error: ${snapshot.error}',
              style: TextStyle(fontSize: 15),
            ),
          );
        } else {
          final content = snapshot.data as String;
          return _FlowCard(
            content: content,
          );
        }
      },
    );
  }
}

class _ActionCard extends ConsumerWidget {
  final ActionBaseParam action;

  const _ActionCard({super.key, required this.action});

  Future<String> getContent(WidgetRef ref) async {
    switch (action.type) {
      case ActionType.BalanceNotificationAction:
        final model = action as AcBalanceNotificationParam;
        return '계좌번호 ${model.account}의 잔액 알림 받기';

      case ActionType.TextNotificationAction:
        final model = action as AcTextNotificationParam;
        return '${model.text} 알림 받기';

      case ActionType.ExchangeRateNotificationAction:
        final model = action as AcExchangeRateNotificationParam;
        return '${model.currency.displayName}의 환율 알림 받기';

      case ActionType.ExchangeAction:
        final model = action as AcExchangeParam;
        final amount = FormatUtil.formatNumber(model.amount);
        final account = model.fromAccount;
        return '${model.currency.displayName}의 계좌번호 $account에서 $amount원 환전하기';

      case ActionType.TransferAction:
        final model = action as AcTransferParam;
        final amount = FormatUtil.formatNumber(model.amount);
        String from = '';
        String to = '';
        final fromResult = await ref
            .read(accountHolderProvider(accountNo: model.fromAccount).future);
        if (fromResult is ErrorModel) {
          return 'balance error';
        } else {
          from =
              (fromResult as ResponseModel<BankBaseModel<AccountHolderModel>>)
                  .data!
                  .rec
                  .userName;
        }
        final toResult = await ref
            .read(accountHolderProvider(accountNo: model.toAccount).future);
        if (toResult is ErrorModel) {
          return 'balance error';
        } else {
          to = (toResult as ResponseModel<BankBaseModel<AccountHolderModel>>)
              .data!
              .rec
              .userName;
        }

        return '$from이 $to에게 $amount원 이체 하기';

      default:
        throw Exception("Unknown TriggerType: ");
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: getContent(ref),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData == false) {
          return CircularProgressIndicator();
        }
        //error가 발생하게 될 경우 반환하게 되는 부분
        else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Error: ${snapshot.error}',
              style: TextStyle(fontSize: 15),
            ),
          );
        } else {
          final content = snapshot.data as String;
          return _FlowCard(
            content: content,
          );
        }
      },
    );
  }
}

class _FlowCard extends StatelessWidget {
  final String content;

  const _FlowCard({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Align(
        child: Container(
          width: double.infinity,
          height: 90.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: const Color(0xFFB5DBFF),
            boxShadow: [
              BoxShadow(
                  color: const Color(0xFF000000).withOpacity(0.25),
                  offset: Offset(0, 4.h),
                  blurRadius: 4.r)
            ],
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            content,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: SHFlowTextStyle.subTitle,
          ),
        ),
      ),
    );
  }
}
