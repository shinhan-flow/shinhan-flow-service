import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shinhan_flow/common/model/base_form_model.dart';
import 'package:shinhan_flow/flow/param/enum/flow_type.dart';

import '../../../common/param/default_param.dart';
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

  @override
  DefaultParam toParam() {
    // TODO: implement toParam
    throw UnimplementedError();
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

  void addTrigger({required TriggerParam trigger}) {
    /// final 로 설정한 List 는 add 를 하지 못하기 때문에 deepCopy 한 후 값 추가
    final triggers = state.triggers.toList();
    if (trigger.code.isTimeType()) {
      triggers.removeWhere((t) => t.code.isTimeType());
    } else if (trigger.code.isProductType()) {
      triggers.removeWhere((t) => t.code.isProductType());
    } else if (trigger.code.isExchangeType()) {
      triggers.removeWhere((t) => t.code.isExchangeType());
    }

    final newTriggers = triggers..add(trigger);
    state = state.copyWith(triggers: newTriggers);
  }
}
