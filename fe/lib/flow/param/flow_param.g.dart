// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flow_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlowParam _$FlowParamFromJson(Map<String, dynamic> json) => FlowParam(
      title: json['title'] as String,
      description: json['description'] as String,
      triggers: (json['triggers'] as List<dynamic>)
          .map((e) => TriggerBaseParam.fromJson(e as Map<String, dynamic>))
          .toList(),
      actions: (json['actions'] as List<dynamic>)
          .map((e) => ActionBaseParam.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FlowParamToJson(FlowParam instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'triggers': instance.triggers,
      'actions': instance.actions,
    };

FlowPParam _$FlowPParamFromJson(Map<String, dynamic> json) => FlowPParam();

Map<String, dynamic> _$FlowPParamToJson(FlowPParam instance) =>
    <String, dynamic>{};
