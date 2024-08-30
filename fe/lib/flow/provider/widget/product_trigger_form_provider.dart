import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_product_param.dart';
import 'package:shinhan_flow/flow/provider/widget/flow_form_provider.dart';
import 'package:shinhan_flow/trigger/model/enum/product_property.dart';

import '../../../common/model/base_form_model.dart';
import '../../../common/param/default_param.dart';
import '../../../trigger/model/enum/time_category.dart';
import '../../param/enum/flow_type.dart';
import '../../param/trigger/trigger_date_time_param.dart';
import '../../param/trigger/trigger_param.dart';

part 'product_trigger_form_provider.g.dart';

@immutable
class TgProductFormModel extends TgProductParam with BaseFormModel {
  TgProductFormModel({
    bool valid = false,
    super.accountProduct,
    super.rate,
  }) {
    this.valid = valid;
  }

  TgProductFormModel copyWith({
    AccountProductType? product,
    double? interestRate,
    TriggerType? type,
  }) {
    final validProduct = product ?? this.accountProduct;
    final validInterestRate = interestRate ?? this.rate;
    final valid = validProduct != null && validInterestRate != null;
    return TgProductFormModel(
      valid: valid,
      accountProduct: product ?? this.accountProduct,
      rate: interestRate ?? this.rate,
    );
  }

  @override
  DefaultParam toParam() {
    return TgProductParam.fromForm(form: this);
  }
}

@riverpod
class TgProductForm extends _$TgProductForm {
  @override
  TgProductFormModel build() {
    return TgProductFormModel();
  }

  void update({
    AccountProductType? property,
    double? interestRate,
  }) {
    state = state.copyWith(
      product: property,
      interestRate: interestRate,
    );
  }
}
