import 'package:json_annotation/json_annotation.dart';

import '../../common/param/default_param.dart';

part 'sign_up_param.g.dart';

@JsonSerializable()
class SignUpParam extends DefaultParam {
  final String name;
  final String email;
  final String password;

  SignUpParam({this.name = '', this.email = '', this.password = ''});

  @override
  List<Object?> get props => [name, email, password];

  SignUpParam copyWith({
    String? name,
    String? email,
    String? password,
  }) {
    return SignUpParam(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toJson() => _$SignUpParamToJson(this);
}
