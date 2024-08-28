import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shinhan_flow/action/model/enum/action_type.dart';
import 'package:shinhan_flow/common/model/base_form_model.dart';
import 'package:shinhan_flow/flow/model/enum/action_category.dart';
import 'package:shinhan_flow/flow/param/enum/flow_type.dart';

import '../../../action/param/action_param.dart';
import '../../../common/param/default_param.dart';
import '../../model/enum/trigger_category.dart';
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
    super.actions = const [],
    bool valid = false,
  }) {
    this.valid = valid;
  }

  @override
  FlowFormModel copyWith({
    String? title,
    String? description,
    List<TriggerBaseParam>? triggers,
    List<ActionBaseParam>? actions,
  }) {
    final validTitle = title ?? this.title;
    final validDescription = description ?? this.description;
    final validTriggers = triggers ?? this.triggers;
    final validActions = actions ?? this.actions;

    final valid = validTitle.isNotEmpty &&
        validDescription.isNotEmpty &&
        validTriggers.isNotEmpty &&
        validActions.isNotEmpty;

    return FlowFormModel(
      title: title ?? this.title,
      description: description ?? this.description,
      triggers: triggers ?? this.triggers,
      actions: actions ?? this.actions,
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
    List<TriggerBaseParam>? triggers,
    List<ActionBaseParam>? actions,
  }) {
    state = state.copyWith(
      title: title,
      description: description,
      triggers: triggers,
      actions: actions,
    );
  }

  void addTrigger({required TriggerBaseParam trigger}) {
    /// final 로 설정한 List 는 add 를 하지 못하기 때문에 deepCopy 한 후 값 추가
    final triggers = state.triggers.toList();
    if (trigger.type.isTimeType()) {
      triggers.removeWhere((t) => t.type.isTimeType());
    } else if (trigger.type.isProductType()) {
      triggers.removeWhere((t) => t.type.isProductType());
    } else if (trigger.type.isExchangeType()) {
      triggers.removeWhere((t) => t.type.isExchangeType());
    } else {
      triggers.removeWhere((t) => t.type.isAccountType());
    }

    final newTriggers = triggers..add(trigger);
    state = state.copyWith(triggers: newTriggers);
  }

  void addAction({required ActionBaseParam action}) {
    /// final 로 설정한 List 는 add 를 하지 못하기 때문에 deepCopy 한 후 값 추가
    final actions = state.actions.toList();
    if (action.type.isNotificationType()) {
      actions.removeWhere((t) => t.type.isNotificationType());
    } else if (action.type.isTransferType()) {
      actions.removeWhere((t) => t.type.isTransferType());
    } else if (action.type.isExchangeType()) {
      actions.removeWhere((t) => t.type.isExchangeType());
    }

    final newActions = actions..add(action);
    state = state.copyWith(actions: newActions);
  }

  void removeTrigger({required TriggerCategoryType trigger}) {
    final triggers = state.triggers.toList();
    if (trigger == TriggerCategoryType.time) {
      triggers.removeWhere((a) => a.type.isTimeType());
    } else if (trigger == TriggerCategoryType.transfer) {
      triggers.removeWhere((a) => a.type.isAccountType());
    } else if (trigger == TriggerCategoryType.exchange) {
      triggers.removeWhere((a) => a.type.isExchangeType());
    } else if (trigger == TriggerCategoryType.product) {
      triggers.removeWhere((a) => a.type.isProductType());
    }

    final newTriggers = triggers.toList();
    state = state.copyWith(triggers: newTriggers);
  }

  void removeAction({required ActionCategoryType action}) {
    final actions = state.actions.toList();
    if (action == ActionCategoryType.notification) {
      actions.removeWhere((a) => a.type.isNotificationType());
    } else if (action == ActionCategoryType.transfer) {
      actions.removeWhere((a) => a.type.isTransferType());
    } else if (action == ActionCategoryType.exchange) {
      actions.removeWhere((a) => a.type.isExchangeType());
    }

    final newActions = actions.toList();
    state = state.copyWith(actions: newActions);
  }
}
