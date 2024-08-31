// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginParam _$LoginParamFromJson(Map<String, dynamic> json) => LoginParam(
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
    );

Map<String, dynamic> _$LoginParamToJson(LoginParam instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
