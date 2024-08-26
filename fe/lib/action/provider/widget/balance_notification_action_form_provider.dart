import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shinhan_flow/action/param/action_balance_notification_param.dart';

import '../../../common/model/base_form_model.dart';
import '../../../common/param/default_param.dart';
import '../../model/enum/action_type.dart';
import '../../param/action_param.dart';

part 'balance_notification_action_form_provider.g.dart';

@immutable
class AcBalanceNotificationFormModel extends AcBalanceNotificationParam
    with BaseFormModel {
  AcBalanceNotificationFormModel({
    bool valid = false,
    super.account = '',
    super.type,
  }) {
    this.valid = valid;
  }

  AcBalanceNotificationFormModel copyWith({
    String? account,
  }) {
    final validAction = account ?? this.account;
    final valid = validAction.isNotEmpty;
    return AcBalanceNotificationFormModel(
      valid: valid,
      account: account ?? this.account,
    );
  }

  @override
  DefaultParam toParam() {
    return AcBalanceNotificationParam.fromForm(form: this);
  }
}

@riverpod
class AcBalanceNotificationForm extends _$AcBalanceNotificationForm {
  @override
  AcBalanceNotificationFormModel build() {
    return AcBalanceNotificationFormModel();
  }

  void update({
    String? account,
  }) {
    state = state.copyWith(
      account: account,
    );
  }
}
