import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shinhan_flow/action/param/action_balance_notification_param.dart';

import '../../../common/model/base_form_model.dart';
import '../../../common/param/default_param.dart';
import '../../model/enum/action_type.dart';
import '../../param/action_param.dart';
import '../../param/action_text_notification_param.dart';
import '../../param/action_transfer_param.dart';

part 'transfer_action_form_provider.g.dart';

@immutable
class AcTransferFormModel extends AcTransferParam with BaseFormModel {
  AcTransferFormModel({
    bool valid = false,
    super.toAccount = '',
    super.amount = 0,
    super.fromAccount = '',
    super.holder = '',
  }) {
    this.valid = valid;
  }

  AcTransferFormModel copyWith({
    String? toAccount,
    String? fromAccount,
    int? amount,
    String? holder,
  }) {
    final validToAccount = toAccount ?? this.toAccount;
    final validFromAccount = fromAccount ?? this.fromAccount;
    final validAmount = amount ?? this.amount;
    final valid = validToAccount.isNotEmpty &&
        validFromAccount.isNotEmpty &&
        validAmount != 0;
    return AcTransferFormModel(
      valid: valid,
      toAccount: toAccount ?? this.toAccount,
      fromAccount: fromAccount ?? this.fromAccount,
      amount: amount ?? this.amount,
      holder: holder ?? this.holder,
    );
  }

  @override
  DefaultParam toParam() {
    return AcTransferParam.fromForm(form: this);
  }
}

@riverpod
class AcTransferForm extends _$AcTransferForm {
  @override
  AcTransferFormModel build() {
    return AcTransferFormModel();
  }

  void update({
    String? toAccount,
    String? fromAccount,
    int? amount,
    String? holder,
  }) {
    state = state.copyWith(
      toAccount: toAccount,
      fromAccount: fromAccount,
      amount: amount,
      holder: holder,
    );
  }
}
