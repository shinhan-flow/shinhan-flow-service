import 'package:json_annotation/json_annotation.dart';

import '../../common/model/default_model.dart';

part 'token_model.g.dart';

@JsonSerializable()
class AccessTokenModel extends BaseModel{
  final String accessToken;

  AccessTokenModel({required this.accessToken});

  factory AccessTokenModel.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenModelFromJson(json);
}


