import 'package:json_annotation/json_annotation.dart';

import '../../common/param/default_param.dart';

part 'login_param.g.dart';

@JsonSerializable()
class LoginParam extends DefaultParam {
  final String email;
  final String password;

  LoginParam({this.email = '', this.password = ''});

  @override
  List<Object?> get props => [email, password];

  LoginParam copyWith({
    String? email,
    String? password,
  }) {
    return LoginParam(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }



  Map<String, dynamic> toJson() => _$LoginParamToJson(this);
}
