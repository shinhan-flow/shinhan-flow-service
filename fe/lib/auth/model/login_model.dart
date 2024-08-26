import 'package:json_annotation/json_annotation.dart';

import '../../common/model/default_model.dart';

part 'login_model.g.dart';

@JsonSerializable()
class AuthModel extends BaseModel {
  final String? accessToken;
  final String? refreshToken;

  AuthModel({
     this.accessToken,
     this.refreshToken,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);
}
