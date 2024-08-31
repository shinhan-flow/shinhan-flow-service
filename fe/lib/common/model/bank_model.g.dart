// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankBaseModel<T> _$BankBaseModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BankBaseModel<T>(
      rec: fromJsonT(json['REC']),
    );

Map<String, dynamic> _$BankBaseModelToJson<T>(
  BankBaseModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'REC': toJsonT(instance.rec),
    };

BankListBaseModel<T> _$BankListBaseModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BankListBaseModel<T>(
      rec: (json['REC'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$BankListBaseModelToJson<T>(
  BankListBaseModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'REC': instance.rec.map(toJsonT).toList(),
    };

RecListModel<T> _$RecListModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    RecListModel<T>(
      list: (json['list'] as List<dynamic>).map(fromJsonT).toList(),
      totalCount: json['totalCount'] as String,
    );

Map<String, dynamic> _$RecListModelToJson<T>(
  RecListModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'list': instance.list.map(toJsonT).toList(),
    };
