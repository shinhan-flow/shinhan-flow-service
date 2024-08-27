import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

import '../logger/custom_logger.dart';

part 'default_model.g.dart';

abstract class BaseModel {}

class LoadingModel extends BaseModel {}

@JsonSerializable()
class CompletedModel extends BaseModel {
  final String code;
  final String message;
  final String? data;

  CompletedModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory CompletedModel.fromJson(Map<String, dynamic> json) =>
      _$CompletedModelFromJson(json);
}

class ErrorModel extends BaseModel {
  final String code;
  final String message;

  ErrorModel({
    required this.code,
    required this.message,
  });

  static ErrorModel respToError(e) {
    // logger.e(e);
    switch (e) {
      case DioException _:
        final resp = e.response!.data;
        return ErrorModel(
          code: resp['code'],
          message: resp['message'],
        );
      default:
        return ErrorModel(
          code: "500",
          message: 'JsonSerializable 에러',
        );
    }
  }
}

@JsonSerializable(
  genericArgumentFactories: true,
)
class ResponseModel<T> extends BaseModel {
  final String code;
  final String message;
  final T? data;

  ResponseModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ResponseModel.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return _$ResponseModelFromJson(json, fromJsonT);
  }

  ResponseModel<T> copyWith({
    String? code,
    String? message,
    T? data,
  }) {
    return ResponseModel<T>(
      code: code ?? this.code,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}

@JsonSerializable(
  genericArgumentFactories: true,
)
class ResponseListModel<T> extends BaseModel {
  final String code;
  final String message;
  final List<T>? data;

  ResponseListModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ResponseListModel.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return _$ResponseListModelFromJson(json, fromJsonT);
  }
}

@JsonSerializable(
  genericArgumentFactories: true,
)
class PaginationModel<T> extends BaseModel {
  // final int start_index;
  final int totalPage;
  final int nowPage;
  final List<T> pageContent;

  PaginationModel({
    // required this.start_index,
    required this.totalPage,
    required this.nowPage,
    required this.pageContent,
  });

  PaginationModel<T> copyWith({
    int? start_index,
    int? totalPage,
    int? nowPage,
    List<T>? pageContent,
  }) {
    return PaginationModel<T>(
      // start_index: start_index ?? this.start_index,
      totalPage: totalPage ?? this.totalPage,
      nowPage: nowPage ?? this.nowPage,
      pageContent: pageContent ?? this.pageContent,
    );
  }

  factory PaginationModel.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return _$PaginationModelFromJson(json, fromJsonT);
  }
}

class PaginationModelRefetching<T> extends PaginationModel<T> {
  PaginationModelRefetching(
      {
      // required super.start_index,
      required super.totalPage,
      required super.nowPage,
      required super.pageContent});
}

class PaginationModelFetchingMore<T> extends PaginationModel<T> {
  PaginationModelFetchingMore(
      {
      // required super.start_index,
      required super.totalPage,
      required super.nowPage,
      required super.pageContent});
}
