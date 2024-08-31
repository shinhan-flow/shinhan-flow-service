// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpParam _$SignUpParamFromJson(Map<String, dynamic> json) => SignUpParam(
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
    );

Map<String, dynamic> _$SignUpParamToJson(SignUpParam instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
    };
