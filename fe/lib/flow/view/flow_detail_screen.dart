import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shinhan_flow/action/param/action_balance_notification_param.dart';
import 'package:shinhan_flow/action/param/action_exchange_param.dart';
import 'package:shinhan_flow/action/param/action_exchange_rate_notification_param.dart';
import 'package:shinhan_flow/action/param/action_text_notification_param.dart';
import 'package:shinhan_flow/action/param/action_transfer_param.dart';
import 'package:shinhan_flow/common/component/default_appbar.dart';
import 'package:shinhan_flow/common/model/default_model.dart';
import 'package:shinhan_flow/flow/model/flow_model.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_param.dart';
import 'package:shinhan_flow/flow/provider/flow_provider.dart';
import 'package:shinhan_flow/theme/text_theme.dart';

import '../../action/model/enum/action_type.dart';
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
      body: NestedScrollView(
          headerSliverBuilder: (_, __) {
            return [
              DefaultAppBar(
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
            ],
          )),
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

class _TriggerCard extends StatelessWidget {
  final TriggerBaseParam trigger;

  const _TriggerCard({super.key, required this.trigger});

  String getContent() {
    switch (trigger.type) {
      case TriggerType.SpecificTimeTrigger:
        trigger as TgTimeParam;
        return '';
      case TriggerType.BalanceTrigger:
        trigger as TgTimeParam;
        return '';
      case TriggerType.DayOfMonthTrigger:
        trigger as TgTimeParam;
        return '';
      case TriggerType.DayOfWeekTrigger:
        trigger as TgTimeParam;
        return '';
      case TriggerType.DepositTrigger:
        trigger as TgTimeParam;
        return '';
      case TriggerType.ExchangeRateTrigger:
        trigger as TgTimeParam;
        return '';
      case TriggerType.InterestRateTrigger:
        trigger as TgTimeParam;
        return '';
      case TriggerType.PeriodDateTrigger:
        trigger as TgTimeParam;
        return '';
      case TriggerType.SpecificDateTrigger:
        trigger as TgTimeParam;
        return '';
      case TriggerType.TransferTrigger:
        trigger as TgTimeParam;
        return '';
      case TriggerType.WithDrawTrigger:
        trigger as TgTimeParam;
        return '';
      // 다른 TriggerType에 대한 처리 추가
      default:
        throw Exception("Unknown TriggerType: ");
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = getContent();
    return _FlowCard(
      content: content,
    );
  }
}

class _ActionCard extends StatelessWidget {
  final ActionBaseParam action;

  const _ActionCard({super.key, required this.action});

  String getContent() {
    switch (action.type) {
      case ActionType.ExchangeRateNotificationAction:
        action as AcExchangeRateNotificationParam;
        return '';
      case ActionType.BalanceNotificationAction:
        action as AcBalanceNotificationParam;
        return '';
      case ActionType.TextNotificationAction:
        action as AcTextNotificationParam;
        return '';
      case ActionType.TransferAction:
        action as AcTransferParam;
        return '';
      case ActionType.ExchangeAction:
        action as AcExchangeParam;
        return '';

      // 다른 TriggerType에 대한 처리 추가
      default:
        throw Exception("Unknown TriggerType: ");
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = getContent();
    return _FlowCard(
      content: content,
    );
  }
}

class _FlowCard extends StatelessWidget {
  final String content;

  const _FlowCard({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        width: double.infinity,
        height: 90.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: const Color(0xFF0057FF)),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Text(
          content,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: SHFlowTextStyle.subTitle,
        ),
      ),
    );
  }
}
