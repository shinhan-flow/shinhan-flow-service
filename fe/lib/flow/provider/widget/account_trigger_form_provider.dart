import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shinhan_flow/flow/model/enum/widget/trigger_enum.dart';
import 'package:shinhan_flow/flow/param/enum/flow_type.dart';
import 'package:shinhan_flow/flow/param/trigger/account/trigger_balance_account_param.dart';
import 'package:shinhan_flow/flow/param/trigger/account/trigger_deposit_account_param.dart';
import 'package:shinhan_flow/flow/param/trigger/account/trigger_transfer_account_param.dart';
import 'package:shinhan_flow/flow/param/trigger/account/trigger_withdraw_account_param.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_param.dart';
import 'package:shinhan_flow/trigger/model/enum/widget/account_property.dart';

import '../../../common/model/base_form_model.dart';
import '../../../common/param/default_param.dart';

part 'account_trigger_form_provider.g.dart';

@immutable
class TgAccountFormModel with BaseFormModel {
  final AccountProperty? property;
  final String? account;
  final int? balance;
  final Condition? condition;
  final int? amount;
  final String? fromAccount;
  final String? toAccount;
  final TriggerType? type;

  TgAccountFormModel({
    this.property,
    this.account,
    this.balance,
    this.amount,
    this.fromAccount,
    this.toAccount,
    this.condition,
    this.type,
    bool valid = false,
  }) {
    this.valid = valid;
  }

  TgAccountFormModel copyWith({
    AccountProperty? property,
    String? account,
    int? balance,
    Condition? condition,
    int? amount,
    String? fromAccount,
    String? toAccount,
    TriggerType? type,
  }) {
    final validProperty = property ?? this.property;
    final validAccount = account ?? this.account;
    final validBalance = balance ?? this.balance;
    final validCondition = condition ?? this.condition;
    final validAmount = amount ?? this.amount;
    final validFromAccount = fromAccount ?? this.fromAccount;
    final validToAccount = toAccount ?? this.toAccount;
    final validType = type ?? this.type;
    bool valid = false;
    if (validType != null) {
      switch (validType) {
        case TriggerType.balance:
          if (validAccount != null &&
              validBalance != null &&
              validCondition != null) {
            valid = validProperty != null &&
                validAccount.isNotEmpty &&
                validBalance > 0;
          }
          break;
        case TriggerType.transfer:
          if (validFromAccount != null &&
              validToAccount != null &&
              validAmount != null) {
            valid = validProperty != null &&
                validFromAccount.isNotEmpty &&
                validToAccount.isNotEmpty &&
                validAmount > 0;
          }
          break;
        case TriggerType.deposit:
          if (validAccount != null && validAmount != null) {
            valid = validProperty != null &&
                validAccount.isNotEmpty &&
                validAmount > 0;
          }
          break;
        case TriggerType.withdraw:
          if (validAccount != null && validAmount != null) {
            valid = validProperty != null &&
                validAccount.isNotEmpty &&
                validAmount > 0;
          }
          break;
        default:
          break;
      }
    }

    return TgAccountFormModel(
      property: property ?? this.property,
      account: account ?? this.account,
      balance: balance ?? this.balance,
      condition: condition ?? this.condition,
      amount: amount ?? this.amount,
      toAccount: toAccount ?? this.toAccount,
      fromAccount: fromAccount ?? this.fromAccount,
      valid: valid,
      type: type ?? this.type,
    );
  }

  @override
  DefaultParam toParam() {
    switch (type!) {
      case TriggerType.balance:
        return TgAccountBalanceParam.fromForm(form: this);
      case TriggerType.deposit:
        return TgAccountDepositParam.fromForm(form: this);
      case TriggerType.transfer:
        return TgAccountTransferParam.fromForm(form: this);
      case TriggerType.withdraw:
        return TgAccountWithdrawParam.fromForm(form: this);
      default:
        return TgAccountWithdrawParam.fromForm(form: this);
    }
  }
}

@riverpod
class TgAccountForm extends _$TgAccountForm {
  @override
  TgAccountFormModel build() {
    return TgAccountFormModel(
      type: TriggerType.balance,
    );
  }

  void update({
    AccountProperty? property,
    String? account,
    int? balance,
    Condition? condition,
    int? amount,
    String? fromAccount,
    String? toAccount,
    TriggerType? type,
  }) {
    state = state.copyWith(
      property: property,
      account: account,
      balance: balance,
      condition: condition,
      amount: amount,
      toAccount: toAccount,
      fromAccount: fromAccount,
      type: type,
    );
  }
}
