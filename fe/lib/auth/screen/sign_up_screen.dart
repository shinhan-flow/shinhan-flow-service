import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shinhan_flow/common/component/default_appbar.dart';
import 'package:shinhan_flow/common/component/text_input_form.dart';
import 'package:shinhan_flow/theme/text_theme.dart';

class SignUpScreen extends StatelessWidget {
  static String get routeName => 'signUp';

  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      onPanDown: (v) => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const DefaultAppBar(
          title: '회원가입',
        ),
        body: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '회원가입에 필요한 개인 정보들을\n입력해주세요!',
                style: SHFlowTextStyle.subTitle,
              ),
              SizedBox(height: 20.h),
              CustomTextFormField(
                label: '이름',
                hintText: '이름을 입력해주세요.',
              ),
              SizedBox(height: 20.h),
              CustomTextFormField(
                label: '아이디',
                hintText: '아이디를 입력해주세요.',
              ),
              SizedBox(height: 20.h),
              CustomTextFormField(
                label: '비밀번호',
                hintText: '비밀번호를 입력해주세요.',
                obscureText: true,
              ),
              SizedBox(height: 20.h),
              CustomTextFormField(
                label: '비밀번호 확인',
                hintText: '비밀번호 확인을 입력해주세요.',
                obscureText: true,
              ),
              const Spacer(),
              TextButton(onPressed: () {}, child: const Text("회원가입"))
            ],
          ),
        ),
      ),
    );
  }
}
