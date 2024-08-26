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
    super.currency = ForeignCurrencyCategory.USD,
    super.fromAccount = '',
    super.amount = 0,
  }) {
    this.valid = false;
  }

  AcExchangeFormModel copyWith({
    ForeignCurrencyCategory? currency,
    String? fromAccount,
    int? amount,
  }) {


    return AcExchangeFormModel(
      valid: true,
      currency: currency ?? this.currency,
      amount: amount ?? this.amount,
      fromAccount: fromAccount ?? this.fromAccount,
    );
  }

  @override
  DefaultParam toParam() {
    return  AcExchangeParam.fromForm(form: this);

  }
}

@riverpod
class AcExchangeForm extends _$AcExchangeForm {
  @override
  AcExchangeFormModel build() {
    return AcExchangeFormModel();
  }

  void update({
    ForeignCurrencyCategory? currency,
  }) {
    state = state.copyWith(
      currency: currency,
    );
  }
}
