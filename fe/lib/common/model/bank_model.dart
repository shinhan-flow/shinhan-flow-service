import 'package:json_annotation/json_annotation.dart';

part 'bank_model.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
)
class BankBaseModel<T> {
  @JsonKey(name: 'REC')
  final T rec;

  BankBaseModel({
    required this.rec,
  });

  factory BankBaseModel.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return _$BankBaseModelFromJson(json, fromJsonT);
  }
}

@JsonSerializable(
  genericArgumentFactories: true,
)
class BankListBaseModel<T> {
  @JsonKey(name: 'REC')
  final List<T> rec;

  BankListBaseModel({
    required this.rec,
  });

  factory BankListBaseModel.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return _$BankListBaseModelFromJson(json, fromJsonT);
  }
}



@JsonSerializable(
  genericArgumentFactories: true,
)
class RecListModel<T> {
  final int totalCount;
  final List<T> list;

  RecListModel({required this.list, required this.totalCount});

  factory RecListModel.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return _$RecListModelFromJson(json, fromJsonT);
  }
}