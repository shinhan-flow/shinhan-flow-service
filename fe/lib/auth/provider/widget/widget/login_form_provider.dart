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
    super.email = '',
    super.password = '',
    bool valid = false,
  }) {
    this.valid = valid;
  }

  @override
  LoginFormModel copyWith({String? email, String? password}) {
    final validEmail = email ?? this.email;
    final validPassword = password ?? this.password;
    final valid = validEmail.isNotEmpty && validPassword.isNotEmpty;

    return LoginFormModel(
        email: email ?? this.email,
        password: password ?? this.password,
        valid: valid);
  }

  @override
  DefaultParam toParam() {
    // TODO: implement toParam
    throw UnimplementedError();
  }
}

@riverpod
class LoginForm extends _$LoginForm {
  @override
  LoginFormModel build() {
    return LoginFormModel();
  }

  void update({String? email, String? password}) {
    state = state.copyWith(email: email, password: password);
  }
}
