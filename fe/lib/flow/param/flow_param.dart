import 'package:json_annotation/json_annotation.dart';
import 'package:shinhan_flow/flow/model/trigger_base_model.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_param.dart';

import '../../common/param/default_param.dart';

part 'flow_param.g.dart';

@JsonSerializable()
class FlowParam extends DefaultParam {
  final String title;
  final String description;
  final List<TriggerParam> triggers;

  FlowParam({
    required this.title,
    required this.description,
    required this.triggers,
  });

  @override
  List<Object?> get props => [title, description, triggers];

  FlowParam copyWith({
    String? title,
    String? description,
    List<TriggerParam>? triggers,
  }) {
    return FlowParam(
      title: title ?? this.title,
      description: description ?? this.description,
      triggers: triggers ?? this.triggers,
    );
  }

  Map<String, dynamic> toJson() => _$FlowParamToJson(this);
}
