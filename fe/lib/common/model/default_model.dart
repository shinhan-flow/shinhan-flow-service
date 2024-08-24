import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

import '../logger/custom_logger.dart';

part 'default_model.g.dart';

abstract class BaseModel {}

class LoadingModel extends BaseModel {}

@JsonSerializable()
class CompletedModel extends BaseModel {
  final int status_code;
  final String message;
  final String? data;

  CompletedModel({
    required this.status_code,
    required this.message,
    required this.data,
  });

  factory CompletedModel.fromJson(Map<String, dynamic> json) =>
      _$CompletedModelFromJson(json);
}

class ErrorModel<T> extends BaseModel {
  final int status_code;
  final String message;
  final T? data;
  final int error_code;

  ErrorModel({
    required this.status_code,
    required this.message,
    required this.data,
    required this.error_code,
  });

  static ErrorModel respToError(e) {
    logger.e(e);
    switch (e.runtimeType) {
      case DioException:
        final resp = (e as DioException).response!.data;
        return ErrorModel(
          status_code: resp['status_code'],
          message: resp['message'],
          data: resp['data'],
          error_code: resp['error_code'],
        );
      default:
        return ErrorModel(
          status_code: 500,
          message: 'JsonSerializable 에러',
          data: '',
          error_code: 0,
        );
    }
  }
}

@JsonSerializable(
  genericArgumentFactories: true,
)
class ResponseModel<T> extends BaseModel {
  final int status_code;
  final String message;
  final T? data;

  ResponseModel({
    required this.status_code,
    required this.message,
    required this.data,
  });

  factory ResponseModel.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return _$ResponseModelFromJson(json, fromJsonT);
  }

  ResponseModel<T> copyWith({
    int? status_code,
    String? message,
    T? data,
  }) {
    return ResponseModel<T>(
      status_code: status_code ?? this.status_code,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}

@JsonSerializable(
  genericArgumentFactories: true,
)
class ResponseListModel<T> extends BaseModel {
  final int status_code;
  final String message;
  final List<T>? data;

  ResponseListModel({
    required this.status_code,
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
  final int start_index;
  final int end_index;
  final int current_index;
  final List<T> page_content;

  PaginationModel({
    required this.start_index,
    required this.end_index,
    required this.current_index,
    required this.page_content,
  });

  PaginationModel<T> copyWith({
    int? start_index,
    int? end_index,
    int? current_index,
    List<T>? page_content,
  }) {
    return PaginationModel<T>(
      start_index: start_index ?? this.start_index,
      end_index: end_index ?? this.end_index,
      current_index: current_index ?? this.current_index,
      page_content: page_content ?? this.page_content,
    );
  }

  factory PaginationModel.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return _$PaginationModelFromJson(json, fromJsonT);
  }
}

class PaginationModelRefetching<T> extends PaginationModel<T> {
  PaginationModelRefetching(
      {required super.start_index,
      required super.end_index,
      required super.current_index,
      required super.page_content});
}

class PaginationModelFetchingMore<T> extends PaginationModel<T> {
  PaginationModelFetchingMore(
      {required super.start_index,
      required super.end_index,
      required super.current_index,
      required super.page_content});
}
