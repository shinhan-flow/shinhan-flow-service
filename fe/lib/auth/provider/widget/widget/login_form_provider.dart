import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shinhan_flow/common/model/base_form_model.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_param.dart';

import '../../../../common/param/default_param.dart';
import '../../../param/login_param.dart';

part 'login_form_provider.g.dart';

@immutable
class LoginFormModel extends LoginParam with BaseFormModel {
  LoginFormModel({
    super.username = '',
    super.password = '',
    bool valid = false,
  }) {
    this.valid = valid;
  }

  @override
  LoginFormModel copyWith({String? username, String? password}) {
    final validEmail = username ?? this.username;
    final validPassword = password ?? this.password;
    final valid = validEmail.isNotEmpty && validPassword.isNotEmpty;

    return LoginFormModel(
        username: username ?? this.username,
        password: password ?? this.password,
        valid: valid);
  }

  @override
  DefaultParam toParam() {
    return LoginParam(username: username, password: password);
  }
}

@riverpod
class LoginForm extends _$LoginForm {
  @override
  LoginFormModel build() {
    return LoginFormModel();
  }

  void update({String? username, String? password}) {
    state = state.copyWith(username: username, password: password);
  }
}
