import 'package:json_annotation/json_annotation.dart';

import '../../common/model/default_model.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel extends BaseModel {
  final String access;
  final String refresh;

  LoginModel({
    required this.access,
    required this.refresh,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);
}
