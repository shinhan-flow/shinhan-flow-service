import 'package:json_annotation/json_annotation.dart';
import 'package:shinhan_flow/common/model/default_model.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_param.dart';

import '../param/flow_param.dart';

part 'flow_model.g.dart';

@JsonSerializable()
class FlowModel extends IModelWithId {
  final int memberId;
  final String title;
  final String description;
  final bool enable;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  FlowModel({
    required super.id,
    required this.memberId,
    required this.title,
    required this.description,
    required this.enable,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  FlowModel copyWith({
    int? memberId,
    String? title,
    String? description,
    bool? enable,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
  }) {
    return FlowModel(
      id: id,
      memberId: memberId ?? this.memberId,
      title: title ?? this.title,
      description: description ?? this.description,
      enable: enable ?? this.enable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  factory FlowModel.fromJson(Map<String, dynamic> json) =>
      _$FlowModelFromJson(json);
}

@JsonSerializable()
class FlowDetailModel extends FlowParam {
  final int id;

  FlowDetailModel({
    required this.id,
    required super.title,
    required super.description,
    required super.triggers,
    required super.actions,
  });

  factory FlowDetailModel.fromJson(Map<String, dynamic> json) =>
      _$FlowDetailModelFromJson(json);
}

@JsonSerializable()
class PromptFlowModel extends BaseModel {
  final FlowParam processed_string;

  PromptFlowModel({
    required this.processed_string,
  });

  factory PromptFlowModel.fromJson(Map<String, dynamic> json) =>
      _$PromptFlowModelFromJson(json);
}
