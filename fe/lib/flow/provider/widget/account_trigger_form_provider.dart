import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shinhan_flow/flow/model/enum/widget/trigger_enum.dart';
import 'package:shinhan_flow/flow/param/enum/flow_type.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_account_param.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_param.dart';
import 'package:shinhan_flow/trigger/model/enum/widget/account_property.dart';

import '../../../common/model/base_form_model.dart';
import '../../../common/param/default_param.dart';

part 'account_trigger_form_provider.g.dart';

@immutable
class TgAccountFormModel extends TgAccountParam with BaseFormModel {
  final AccountProperty? property;
  final AccountThanType? thanType;

  TgAccountFormModel({
    this.property,
    super.account = '',
    super.price = 0,
    bool valid = false,
    this.thanType,
    required super.type,
  }) {
    this.valid = valid;
  }

  TgAccountFormModel copyWith({
    TriggerType? type,
    AccountProperty? property,
    String? account,
    int? price,
    AccountThanType? thanType,
  }) {
    final validProperty = property ?? this.property;
    final validAccount = account ?? this.account;
    final validPrice = price ?? this.price;
    final validThanType = thanType ?? this.thanType;

    bool valid =
        validProperty != null && validAccount.isNotEmpty && validPrice > 0;
    if (validProperty != null && validProperty == AccountProperty.balance) {
      valid = validThanType != null;
    }

    return TgAccountFormModel(
      property: property ?? this.property,
      account: account ?? this.account,
      price: price ?? this.price,
      valid: valid,
      thanType: thanType ?? this.thanType,
      type: type ?? this.type,
    );
  }

  @override
  DefaultParam toParam() {
    // TODO: implement toParam
    throw UnimplementedError();
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
    int? price,
    AccountThanType? thanType,
    TriggerType? type,
  }) {
    state = state.copyWith(
      property: property,
      account: account,
      price: price,
      thanType: thanType,
      type: type,
    );
  }
}
