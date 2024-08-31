import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shinhan_flow/account/component/account_card.dart';
import 'package:shinhan_flow/common/component/bottom_nav_button.dart';
import 'package:shinhan_flow/common/component/default_appbar.dart';
import 'package:shinhan_flow/common/component/default_text_button.dart';
import 'package:shinhan_flow/common/component/text_input_form.dart';
import 'package:shinhan_flow/flow/view/flow_detail_screen.dart';
import 'package:shinhan_flow/prompt/provider/prompt_provider.dart';
import 'package:shinhan_flow/theme/text_theme.dart';

import '../../common/model/default_model.dart';
import '../../flow/model/flow_model.dart';
import '../../home_screen.dart';

final inputProvider = StateProvider<String?>((ref) => null);

class PromptScreen extends ConsumerWidget {
  static String get routeName => 'prompt';

  const PromptScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(promptInputProvider);
    return Scaffold(
      bottomNavigationBar: BottomNavButton(
        child: DefaultTextButton(
            onPressed: () async {
              final result = await ref.read(promptProvider.future);
              if (result is ErrorModel) {
              } else {
                final model = (result as PromptFlowModel);
                log('model.processed_string.triggers ${model.processed_string.triggers}');
                context.pushNamed(FlowDetailScreen.routeName);
              }
            },
            text: '생성하기',
            able: true),
      ),
      appBar: DefaultAppBar(
        title: 'AI 플로우 생성',
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 24.w),
            sliver: SliverMainAxisGroup(slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'AI를 이용하여 플로우 생성',
                      style: SHFlowTextStyle.subTitle,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "AI에게 원하시는 은행 업무를 만들어달라고 해보세요!",
                      style: SHFlowTextStyle.subTitle,
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    CustomTextFormField(
                      hintText: '플로우 생성을 위한 정보를 입력해보세요.',
                      onChanged: (v) {
                        // ref.read(inputProvider.notifier).update((i) => v);
                        ref.read(promptInputProvider.notifier).update((i) => v);
                      },
                    ),
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
