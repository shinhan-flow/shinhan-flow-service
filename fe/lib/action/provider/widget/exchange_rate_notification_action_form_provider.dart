import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shinhan_flow/action/param/action_balance_notification_param.dart';
import 'package:shinhan_flow/trigger/model/enum/foreign_currency_category.dart';

import '../../../common/model/base_form_model.dart';
import '../../../common/param/default_param.dart';
import '../../param/action_exchange_rate_notification_param.dart';

part 'exchange_rate_notification_action_form_provider.g.dart';

@immutable
class AcExchangeRateNotificationFormModel
    extends AcExchangeRateNotificationParam with BaseFormModel {
  AcExchangeRateNotificationFormModel({
    bool valid = false,
    super.currency = CurrencyType.USD,
  }) {
    this.valid = valid;
  }

  AcExchangeRateNotificationFormModel copyWith({
    CurrencyType? currency,
  }) {
    return AcExchangeRateNotificationFormModel(
      valid: true,
      currency: currency ?? this.currency,
    );
  }

  @override
  DefaultParam toParam() {
    return AcExchangeRateNotificationParam.fromForm(form: this);
  }
}

@riverpod
class AcExchangeRateNotificationForm extends _$AcExchangeRateNotificationForm {
  @override
  AcExchangeRateNotificationFormModel build() {
    return AcExchangeRateNotificationFormModel();
  }

  void update({
    CurrencyType? currency,
  }) {
    state = state.copyWith(
      currency: currency,
    );
  }
}
