import 'package:json_annotation/json_annotation.dart';

import '../../common/param/default_param.dart';

part 'login_param.g.dart';

@JsonSerializable()
class LoginParam extends DefaultParam {
  final String username;
  final String password;

  LoginParam({this.username = '', this.password = ''});

  @override
  List<Object?> get props => [username, password];

  LoginParam copyWith({
    String? username,
    String? password,
  }) {
    return LoginParam(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toJson() => _$LoginParamToJson(this);
}
