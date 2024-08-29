import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shinhan_flow/auth/provider/sign_up_provider.dart';
import 'package:shinhan_flow/auth/view/login_screen.dart';
import 'package:shinhan_flow/common/component/default_appbar.dart';
import 'package:shinhan_flow/common/component/default_flashbar.dart';
import 'package:shinhan_flow/common/component/default_text_button.dart';
import 'package:shinhan_flow/common/component/text_input_form.dart';
import 'package:shinhan_flow/common/model/default_model.dart';
import 'package:shinhan_flow/theme/text_theme.dart';
import 'package:shinhan_flow/util/reg_exp_util.dart';

import '../../common/provider/widget/select_provider.dart';
import '../provider/widget/widget/sign_up_form_provider.dart';

final signUpViewProvider = StateProvider.autoDispose<int>((ref) => 0);

class SignUpScreen extends ConsumerStatefulWidget {
  static String get routeName => 'signUp';

  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  late final List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    focusNodes = [
      FocusNode(),
      FocusNode(),
      FocusNode(),
    ];
  }

  Widget _infoForm(WidgetRef ref, SignUpFormModel form, BuildContext context) {
    final isVisible1 = ref.watch(selectProvider(2));
    final isVisible2 = ref.watch(selectProvider(3));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '회원가입에 필요한 개인 정보들을\n입력해주세요!',
          style: SHFlowTextStyle.subTitle,
        ),
        SizedBox(height: 20.h),
        CustomTextFormField(
          focusNode: focusNodes[0],
          textInputAction: TextInputAction.next,
          label: '이름',
          hintText: '이름을 입력해주세요.',
          onChanged: (v) {
            ref.read(signUpFormProvider.notifier).update(name: v);
          },
        ),
        SizedBox(height: 20.h),
        CustomTextFormField(
          label: '이메일',
          hintText: '이메일을 입력해주세요.',
          initialValue: form.email,
          enable: false,
        ),
        SizedBox(height: 20.h),
        CustomTextFormField(
          focusNode: focusNodes[1],
          textInputAction: TextInputAction.next,
          label: '비밀번호',
          hintText: '비밀번호를 입력해주세요.',
          obscureText: !isVisible1,
          onChanged: (v) {
            ref.read(signUpFormProvider.notifier).update(password: v);
          },
          suffix: focusNodes[1].hasFocus
              ? Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: GestureDetector(
                    onTap: () {
                      ref.read(selectProvider(2).notifier).update((s) => !s);
                    },
                    child: isVisible1
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                )
              : null,
        ),
        SizedBox(height: 20.h),
        CustomTextFormField(
          focusNode: focusNodes[2],
          label: '비밀번호 확인',
          hintText: '비밀번호 확인을 입력해주세요.',
          obscureText: !isVisible2,
          onChanged: (v) {
            ref.read(signUpFormProvider.notifier).update(checkPassword: v);
          },
          suffix: focusNodes[2].hasFocus
              ? Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: GestureDetector(
                    onTap: () {
                      ref.read(selectProvider(3).notifier).update((s) => !s);
                    },
                    child: isVisible2
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                )
              : null,
        ),
        const Spacer(),
        DefaultTextButton(
          onPressed: () async {
            final result = await ref.read(signUpProvider.future);
            if (result is ErrorModel) {
            } else {
              if (context.mounted) {
                context.goNamed(LoginScreen.routeName);
                FlashUtil.showFlash(context, "회원가입 완료!",
                    textColor: const Color(0xFF49B7FF));
              }
            }
          },
          text: '회원가입',
          able: form.valid,
        ),
      ],
    );
  }

  @override
  void dispose() {
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(signUpFormProvider);
    final viewOrder = ref.watch(signUpViewProvider);
    final view =
        viewOrder == 0 ? _EmailValidForm() : _infoForm(ref, form, context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      // onPanDown: (v) => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const DefaultAppBar(
          title: '회원가입',
        ),
        body: Padding(
          padding: EdgeInsets.all(24.r),
          child: view,
        ),
      ),
    );
  }
}

class _EmailValidForm extends ConsumerStatefulWidget {
  const _EmailValidForm({super.key});

  @override
  ConsumerState<_EmailValidForm> createState() => _EmailValidFormState();
}

class _EmailValidFormState extends ConsumerState<_EmailValidForm> {
  bool showCodeForm = false;
  bool requestValid = false;

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(signUpFormProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "신한 Flow에서 사용하실\n이메일을 입력해주세요.", //"이메일 인증을 해주세요.",
          style: SHFlowTextStyle.subTitle,
        ),
        SizedBox(height: 20.h),
        CustomTextFormField(
          label: '이메일',
          hintText: '이메일을 입력해주세요.',
          onChanged: (v) {
            ref.read(signUpFormProvider.notifier).update(email: v);
            setState(() {
              requestValid = RegExpUtil.email(v);
            });
          },
          // side: DefaultTextButton(
          //   onPressed: requestValid
          //       ? () {
          //           setState(() {
          //             showCodeForm = true;
          //           });
          //         }
          //       : null,
          //   stretch: false,
          //   text: '요청하기',
          //   able: requestValid,
          // ),
        ),
        SizedBox(height: 20.h),
        Expanded(
          child: Visibility(
              visible: true, // showCodeForm,
              child: Column(
                children: [
                  // CustomTextFormField(
                  //   hintText: '인증번호를 입력해주세요.',
                  //   onChanged: (v) {
                  //     if (v.length == 6) {
                  //       FocusScope.of(context).unfocus();
                  //     } else {}
                  //     ref
                  //         .read(signUpFormProvider.notifier)
                  //         .update(validCode: v);
                  //   },
                  // ),
                  const Spacer(),
                  Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      final email = ref.watch(signUpFormProvider).email;
                      final valid = RegExpUtil.email(email);
                      return DefaultTextButton(
                        onPressed: () {
                          ref
                              .read(signUpViewProvider.notifier)
                              .update((v) => 1);
                        },
                        text: '다음',
                        able: valid, //form.validCode.length == 6,
                      );
                    },
                  ),
                  // SizedBox(height: 20.h)
                ],
              )),
        ),
      ],
    );
  }
}
