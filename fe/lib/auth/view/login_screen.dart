import 'dart:developer';
import 'dart:math' hide log;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shinhan_flow/account/model/account_model.dart';
import 'package:shinhan_flow/auth/provider/login_provider.dart';
import 'package:shinhan_flow/auth/provider/widget/widget/login_form_provider.dart';
import 'package:shinhan_flow/auth/view/sign_up_screen.dart';
import 'package:shinhan_flow/common/component/default_appbar.dart';
import 'package:shinhan_flow/common/component/default_text_button.dart';
import 'package:shinhan_flow/common/component/text_input_form.dart';
import 'package:shinhan_flow/common/model/default_model.dart';
import 'package:shinhan_flow/theme/text_theme.dart';
import 'package:shinhan_flow/util/util.dart';

import '../provider/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  static String get routeName => 'login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Object json = {"account": "3412312", "balance": 412344, "condition": "LT"};

    final model = TrashModel.fromJson(json as Map<String, dynamic>);
    log('model ${model}');
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      onPanDown: (v) => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 34.h),
                Image.asset(
                  AssetUtil.getAssetPath(
                    name: 'logo',
                    extension: 'png',
                  ),
                  height: 90.h,
                  width: 152.w,
                ),
                SizedBox(height: 6.h),
                Text(
                  'Shinhan Flow',
                  style: SHFlowTextStyle.title
                      .copyWith(color: const Color(0xFF172FFF)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Text(
                  'Shinhan Flow 에서 간편하게\n은행 업무를 진행해보세요!',
                  style: SHFlowTextStyle.caption
                      .copyWith(color: const Color(0xFF4c4c4c)),
                  textAlign: TextAlign.center,
                ),
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    return CustomTextFormField(
                      label: '이메일',
                      hintText: '이메일를 입력해주세요.',
                      onChanged: (v) {
                        ref.read(loginFormProvider.notifier).update(email: v);
                      },
                    );
                  },
                ),
                SizedBox(height: 18.h),
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    return CustomTextFormField(
                      label: '비밀번호',
                      hintText: '비밀번호를 입력해주세요.',
                      obscureText: true,
                      onChanged: (v) {
                        ref
                            .read(loginFormProvider.notifier)
                            .update(password: v);
                      },
                    );
                  },
                ),
                SizedBox(height: 44.h),
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    final valid =
                        ref.watch(loginFormProvider.select((p) => p.valid));

                    return DefaultTextButton(
                      onPressed: () async {
                        final result = await ref.read(loginProvider.future);

                        if (result is ErrorModel) {
                        } else {
                          if (context.mounted) {
                            await ref
                                .read(authProvider.notifier)
                                .autoLogin(context: context);
                          }
                        }
                      },
                      text: '로그인',
                      able: valid,
                    );
                  },
                ),
                SizedBox(height: 18.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "아직 회원이 아니신가요?",
                        style: SHFlowTextStyle.label
                            .copyWith(color: const Color(0xFF8c8c8c)),
                      ),
                      GestureDetector(
                        onTap: () => context.goNamed(SignUpScreen.routeName),
                        child: Text(
                          "회원가입하기",
                          style: SHFlowTextStyle.label
                              .copyWith(color: const Color(0xFF5160E4)),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Text(
                        "고객센터",
                        style: SHFlowTextStyle.label
                            .copyWith(color: const Color(0xFF8c8c8c)),
                      ),
                    ),
                    Text(
                      " | ",
                      style: SHFlowTextStyle.label
                          .copyWith(color: const Color(0xFF8c8c8c)),
                    ),
                    InkWell(
                      child: Text(
                        "ID / PW 를 잊으셨나요?",
                        style: SHFlowTextStyle.label
                            .copyWith(color: const Color(0xFF8c8c8c)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 64.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
