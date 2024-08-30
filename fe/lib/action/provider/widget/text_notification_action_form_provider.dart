import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/model/base_form_model.dart';
import '../../../common/param/default_param.dart';
import '../../param/action_text_notification_param.dart';

part 'text_notification_action_form_provider.g.dart';

@immutable
class AcTextNotificationFormModel extends AcTextNotificationParam
    with BaseFormModel {
  AcTextNotificationFormModel({
    bool valid = false,
    super.text = '',
  }) {
    this.valid = valid;
  }

  AcTextNotificationFormModel copyWith({
    String? text,
  }) {
    final validAction = text ?? this.text;
    final valid = validAction.isNotEmpty;
    return AcTextNotificationFormModel(
      valid: valid,
      text: text ?? this.text,
    );
  }

  @override
  DefaultParam toParam() {
    return AcTextNotificationParam.fromForm(form: this);
  }
}

@riverpod
class AcTextNotificationForm extends _$AcTextNotificationForm {
  @override
  AcTextNotificationFormModel build() {
    return AcTextNotificationFormModel();
  }

  void update({
    String? text,
  }) {
    state = state.copyWith(
      text: text,
    );
  }
}
