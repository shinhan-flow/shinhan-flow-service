// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flow_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlowModel _$FlowModelFromJson(Map<String, dynamic> json) => FlowModel(
      id: (json['id'] as num).toInt(),
      memberId: (json['memberId'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      enable: json['enable'] as bool,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      deletedAt: json['deletedAt'] as String?,
    );

Map<String, dynamic> _$FlowModelToJson(FlowModel instance) => <String, dynamic>{
      'id': instance.id,
      'memberId': instance.memberId,
      'title': instance.title,
      'description': instance.description,
      'enable': instance.enable,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'deletedAt': instance.deletedAt,
    };

FlowDetailModel _$FlowDetailModelFromJson(Map<String, dynamic> json) =>
    FlowDetailModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      triggers: (json['triggers'] as List<dynamic>)
          .map((e) => TriggerBaseParam.fromJson(e as Map<String, dynamic>))
          .toList(),
      actions: (json['actions'] as List<dynamic>)
          .map((e) => ActionBaseParam.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FlowDetailModelToJson(FlowDetailModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'triggers': instance.triggers,
      'actions': instance.actions,
      'id': instance.id,
    };

PromptFlowModel _$PromptFlowModelFromJson(Map<String, dynamic> json) =>
    PromptFlowModel(
      processed_string:
          FlowParam.fromJson(json['processed_string'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PromptFlowModelToJson(PromptFlowModel instance) =>
    <String, dynamic>{
      'processed_string': instance.processed_string,
    };
