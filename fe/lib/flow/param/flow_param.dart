import 'package:json_annotation/json_annotation.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_param.dart';

import '../../action/param/action_param.dart';
import '../../common/param/default_param.dart';

part 'flow_param.g.dart';

@JsonSerializable()
class FlowParam extends DefaultParam {
  final String title;
  final String description;
  final List<TriggerBaseParam> triggers;
  final List<ActionBaseParam> actions;

  FlowParam({
    required this.title,
    required this.description,
    required this.triggers,
    required this.actions,
  });

  @override
  List<Object?> get props => [title, description, triggers, actions];

  FlowParam copyWith({
    String? title,
    String? description,
    List<TriggerBaseParam>? triggers,
    List<ActionBaseParam>? actions,
  }) {
    return FlowParam(
      title: title ?? this.title,
      description: description ?? this.description,
      triggers: triggers ?? this.triggers,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toJson() => _$FlowParamToJson(this);
}
