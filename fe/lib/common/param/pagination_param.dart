import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'default_param.dart';

part 'pagination_param.g.dart';

class PaginationStateParam<T extends DefaultParam> extends Equatable {
  final T? param;
  final int? path;

  PaginationStateParam({
    this.param,
    this.path,
  });

  @override
  List<Object?> get props => [param, path];

  @override
  bool? get stringify => true;
}

@JsonSerializable()
class PaginationParam extends Equatable {
  final int nowPage;
  final int perPage;

  const PaginationParam({
    required this.nowPage,
    required this.perPage,
  });

  PaginationParam copyWith({
    int? page,
  }) {
    return PaginationParam(
      nowPage: page ?? nowPage,
      perPage: perPage,
    );
  }

  Map<String, dynamic> toJson() => _$PaginationParamToJson(this);

  @override
  List<Object?> get props => [nowPage, perPage];

  @override
  bool? get stringify => true;
}
