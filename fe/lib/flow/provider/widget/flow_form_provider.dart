import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shinhan_flow/common/model/base_form_model.dart';

import '../../model/enum/widget/flow_property.dart';
import '../../param/flow_param.dart';
import '../../param/trigger/trigger_param.dart';

part 'flow_form_provider.g.dart';

final showFlowDeleteProvider =
    StateProvider.family.autoDispose<bool, FlowProperty>((ref, type) => false);

@immutable
class FlowFormModel extends FlowParam with BaseFormModel {
  FlowFormModel({
    super.title = '',
    super.description = '',
    super.triggers = const [],
    bool valid = false,
  }) {
    this.valid = valid;
  }

  @override
  FlowFormModel copyWith({
    String? title,
    String? description,
    List<TriggerParam>? triggers,
  }) {
    final validTitle = title ?? this.title;
    final validDescription = description ?? this.description;

    final valid = validTitle.isNotEmpty && validDescription.isNotEmpty;

    return FlowFormModel(
      title: title ?? this.title,
      description: description ?? this.description,
      triggers: triggers ?? this.triggers,
      valid: valid,
    );
  }
}

@riverpod
class FlowForm extends _$FlowForm {
  @override
  FlowFormModel build() {
    return FlowFormModel();
  }

  void update({
    String? title,
    String? description,
    List<TriggerParam>? triggers,
  }) {
    state = state.copyWith(
      title: title,
      description: description,
      triggers: triggers,
    );
  }
}
