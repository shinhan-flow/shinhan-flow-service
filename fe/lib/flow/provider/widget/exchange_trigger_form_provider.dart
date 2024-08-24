import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_product_param.dart';
import 'package:shinhan_flow/flow/provider/widget/flow_form_provider.dart';
import 'package:shinhan_flow/trigger/model/enum/foreign_currency_category.dart';
import 'package:shinhan_flow/trigger/model/enum/product_property.dart';

import '../../../common/model/base_form_model.dart';
import '../../../common/param/default_param.dart';
import '../../../trigger/model/enum/time_category.dart';
import '../../param/enum/flow_type.dart';
import '../../param/trigger/trigger_date_time_param.dart';
import '../../param/trigger/trigger_exchange_param.dart';
import '../../param/trigger/trigger_param.dart';

part 'exchange_trigger_form_provider.g.dart';

@immutable
class TgExchangeFormModel extends TgExchangeParam with BaseFormModel {
  TgExchangeFormModel({
    bool valid = false,
    super.currency = ForeignCurrencyCategory.USD,
    super.exRate = 1300,
  }) {
    this.valid = valid;
  }

  TgExchangeFormModel copyWith({
    ForeignCurrencyCategory? currency,
    double? exRate,
  }) {
    final validCurrency = currency ?? this.currency;
    final validExRate = exRate ?? this.exRate;
    final valid = validCurrency != null && validExRate != null;
    return TgExchangeFormModel(
      valid: valid,
      currency: currency ?? this.currency,
      exRate: exRate ?? this.exRate,
    );
  }

  @override
  DefaultParam toParam() {
    return TriggerParam(
      code: FlowType.exchangeRate,
      data: TgExchangeParam.fromForm(form: this),
    );
  }
}

@riverpod
class TgExchangeForm extends _$TgExchangeForm {
  @override
  TgExchangeFormModel build() {
    return TgExchangeFormModel();
  }

  void update({
    ForeignCurrencyCategory? currency,
    double? exRate,
  }) {
    state = state.copyWith(
      currency: currency,
      exRate: exRate,
    );
  }
}
