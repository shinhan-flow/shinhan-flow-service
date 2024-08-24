import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shinhan_flow/common/model/base_form_model.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_param.dart';

import '../../../../common/param/default_param.dart';
import '../../../param/sign_up_param.dart';

part 'sign_up_form_provider.g.dart';

@immutable
class SignUpFormModel extends SignUpParam with BaseFormModel {
  final String checkPassword;
  final String validCode;

  SignUpFormModel({
    super.name = '',
    super.email = '',
    super.password = '',
    bool valid = false,
    this.checkPassword = '',
    this.validCode = '',
  }) {
    this.valid = valid;
  }

  @override
  SignUpFormModel copyWith({
    String? name,
    String? email,
    String? password,
    String? checkPassword,
    String? validCode,
  }) {
    final validName = name ?? this.name;
    final validEmail = email ?? this.email;
    final validPassword = password ?? this.password;
    final validCheckPassword = checkPassword ?? this.checkPassword;

    final validPw = validPassword.isNotEmpty &&
        validPassword.compareTo(validCheckPassword) == 0;

    final valid = validName.isNotEmpty && validEmail.isNotEmpty && validPw;

    // log("valid = $validPw");

    return SignUpFormModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      checkPassword: checkPassword ?? this.checkPassword,
      valid: valid,
      validCode: validCode ?? this.validCode,
    );
  }

  @override
  DefaultParam toParam() {
    return SignUpParam(email: email, password: password, name: name);
  }
}

@riverpod
class SignUpForm extends _$SignUpForm {
  @override
  SignUpFormModel build() {
    return SignUpFormModel();
  }

  void update({
    String? name,
    String? email,
    String? password,
    String? checkPassword,
    String? validCode,
  }) {
    state = state.copyWith(
      name: name,
      email: email,
      password: password,
      checkPassword: checkPassword,
      validCode: validCode,
    );
  }
}
