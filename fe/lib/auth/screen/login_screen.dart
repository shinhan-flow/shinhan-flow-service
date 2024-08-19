import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shinhan_flow/auth/screen/sign_up_screen.dart';
import 'package:shinhan_flow/common/component/default_appbar.dart';
import 'package:shinhan_flow/common/component/text_input_form.dart';
import 'package:shinhan_flow/theme/text_theme.dart';
import 'package:shinhan_flow/util/util.dart';

class LoginScreen extends StatelessWidget {
  static String get routeName => 'login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                const CustomTextFormField(
                  label: '아이디',
                  hintText: '아이디를 입력해주세요.',
                ),
                SizedBox(height: 18.h),
                const CustomTextFormField(
                  label: '비밀번호',
                  hintText: '비밀번호를 입력해주세요.',
                  obscureText: true,
                ),
                SizedBox(height: 44.h),
                TextButton(onPressed: () {}, child: const Text("로그인")),
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
