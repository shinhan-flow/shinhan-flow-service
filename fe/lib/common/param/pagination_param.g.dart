// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationParam _$PaginationParamFromJson(Map<String, dynamic> json) =>
    PaginationParam(
      nowPage: (json['nowPage'] as num).toInt(),
      perPage: (json['perPage'] as num).toInt(),
    );

Map<String, dynamic> _$PaginationParamToJson(PaginationParam instance) =>
    <String, dynamic>{
      'nowPage': instance.nowPage,
      'perPage': instance.perPage,
    };
