import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shinhan_flow/action/param/action_balance_notification_param.dart';
import 'package:shinhan_flow/trigger/model/enum/foreign_currency_category.dart';

import '../../../common/model/base_form_model.dart';
import '../../../common/param/default_param.dart';
import '../../model/enum/action_type.dart';
import '../../param/action_exchange_param.dart';
import '../../param/action_exchange_rate_notification_param.dart';
import '../../param/action_param.dart';

part 'exchange_action_form_provider.g.dart';

@immutable
class AcExchangeFormModel extends AcExchangeParam with BaseFormModel {
  AcExchangeFormModel({
    bool valid = false,
    super.currency = CurrencyType.USD,
    super.fromAccount = '',
    super.amount = 0,
  }) {
    this.valid = false;
  }

  AcExchangeFormModel copyWith({
    CurrencyType? currency,
    String? fromAccount,
    int? amount,
  }) {
    final validCurrency = currency ?? this.currency;
    final validFromAccount = fromAccount ?? this.fromAccount;
    final validAmount = amount ?? this.amount;

    final valid = validFromAccount.isNotEmpty && validAmount > 0;
  log("inner valid = $valid");
    return AcExchangeFormModel(
      valid: valid,
      currency: currency ?? this.currency,
      amount: amount ?? this.amount,
      fromAccount: fromAccount ?? this.fromAccount,
    );
  }

  @override
  DefaultParam toParam() {
    return AcExchangeParam.fromForm(form: this);
  }
}

@riverpod
class AcExchangeForm extends _$AcExchangeForm {
  @override
  AcExchangeFormModel build() {
    return AcExchangeFormModel();
  }

  void update({
    String? fromAccount,
    CurrencyType? currency,
    int? amount,
  }) {
    state = state.copyWith(
      currency: currency,
      fromAccount: fromAccount,
      amount: amount,
    );
  }
}
