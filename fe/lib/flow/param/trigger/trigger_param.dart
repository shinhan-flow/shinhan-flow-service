/*
1. 주기생성
    1. 일반(0)
        날짜를 단 하루 지정합니다.
    2. 기간(1)
        연속된 날짜를 지정합니다.
    3. 반복(2)
        1. 매주
            매주 반복되는 요일을 설정합니다.
            시작 날짜필수 종료날짜 미선택시 무한반복
        2. 매월
            매달 특정일을 지정해서 반복합니다.
            1일, 12일, 29일 등등
    4. 다중(3)
        마구잡이로 여러 날짜를 선택합니다.
 */
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shinhan_flow/action/param/action_balance_notification_param.dart';
import 'package:shinhan_flow/action/param/action_exchange_param.dart';
import 'package:shinhan_flow/action/param/action_exchange_rate_notification_param.dart';
import 'package:shinhan_flow/action/param/action_text_notification_param.dart';
import 'package:shinhan_flow/action/param/action_transfer_param.dart';
import 'package:shinhan_flow/flow/param/trigger/account/trigger_balance_account_param.dart';
import 'package:shinhan_flow/flow/param/trigger/account/trigger_deposit_account_param.dart';
import 'package:shinhan_flow/flow/param/trigger/account/trigger_transfer_account_param.dart';
import 'package:shinhan_flow/flow/param/trigger/account/trigger_withdraw_account_param.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_date_time_param.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_exchange_param.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_product_param.dart';

import '../../../action/model/enum/action_type.dart';
import '../../../common/param/default_param.dart';
import '../enum/flow_type.dart';

part 'trigger_param.g.dart';

@JsonSerializable()
class ActionBaseParam extends DefaultParam {
  final ActionType type;

  ActionBaseParam({required this.type});

  Map<String, dynamic> toJson() {
    return {};
  }

  factory ActionBaseParam.fromJson(Map<String, dynamic> json) {
    ActionType type = ActionType.values.byName(json['type'] as String);

    switch (type) {
      case ActionType.ExchangeAction:
        return AcExchangeParam.fromJson(json);
      case ActionType.TransferAction:
        return AcTransferParam.fromJson(json);
      case ActionType.TextNotificationAction:
        return AcTextNotificationParam.fromJson(json);
      case ActionType.BalanceNotificationAction:
        return AcBalanceNotificationParam.fromJson(json);
      case ActionType.ExchangeRateNotificationAction:
        return AcExchangeRateNotificationParam.fromJson(json);

      // 다른 TriggerType에 대한 처리 추가
      default:
        throw Exception("Unknown TriggerType: $type");
    }
  }

  @override
  List<Object?> get props => [type];

  @override
  bool? get stringify => true;
}

@JsonSerializable()
class TriggerBaseParam extends DefaultParam {
  final TriggerType type;

  TriggerBaseParam({required this.type});

  Map<String, dynamic> toJson() {
    return {};
  }

  //
  // factory TriggerBaseParam.fromJson(Map<String, dynamic> json) =>
  //     _$TriggerBaseParamFromJson(json);

  factory TriggerBaseParam.fromJson(Map<String, dynamic> json) {
    TriggerType type = TriggerType.values.byName(json['type'] as String);
    switch (type) {
      case TriggerType.SpecificTimeTrigger:
        return TgTimeParam.fromJson(json);
      case TriggerType.BalanceTrigger:
        return TgAccountBalanceParam.fromJson(json);
      case TriggerType.DayOfMonthTrigger:
        return TgDayOfMonthParam.fromJson(json);
      case TriggerType.DayOfWeekTrigger:
        return TgDayOfWeekParam.fromJson(json);
      case TriggerType.DepositTrigger:
        return TgAccountDepositParam.fromJson(json);
      case TriggerType.ExchangeRateTrigger:
        return TgExchangeParam.fromJson(json);
      case TriggerType.InterestRateTrigger:
        return TgProductParam.fromJson(json);
      case TriggerType.PeriodDateTrigger:
        return TgPeriodDateParam.fromJson(json);
      case TriggerType.SpecificDateTrigger:
        return TgSpecificDateParam.fromJson(json);
      case TriggerType.TransferTrigger:
        return TgAccountTransferParam.fromJson(json);
      case TriggerType.WithDrawTrigger:
        return TgAccountWithdrawParam.fromJson(json);
      // 다른 TriggerType에 대한 처리 추가
      default:
        throw Exception("Unknown TriggerType: $type");
    }
  }

  @override
  List<Object?> get props => [type];

  @override
  bool? get stringify => true;
}
