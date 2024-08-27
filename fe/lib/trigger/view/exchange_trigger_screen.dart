import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shinhan_flow/auth/view/login_screen.dart';
import 'package:shinhan_flow/common/component/bottom_nav_button.dart';
import 'package:shinhan_flow/common/component/default_appbar.dart';
import 'package:shinhan_flow/flow/provider/widget/exchange_trigger_form_provider.dart';
import 'package:shinhan_flow/theme/text_theme.dart';
import 'package:shinhan_flow/trigger/model/enum/foreign_currency_category.dart';

import '../../common/component/default_text_button.dart';
import '../../common/component/drop_down_button.dart';
import '../../flow/param/trigger/trigger_param.dart';
import '../../flow/provider/widget/flow_form_provider.dart';

class ExchangeTriggerScreen extends StatelessWidget {
  static String get routeName => 'exchange';

  const ExchangeTriggerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavButton(child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final valid = ref.watch(tgExchangeFormProvider).valid;

          return DefaultTextButton(
            onPressed: valid
                ? () {
                    final trigger = ref.read(tgExchangeFormProvider);
                    ref
                        .read(flowFormProvider.notifier)
                        .addTrigger(trigger: trigger.toParam() as TriggerBaseParam);
                    context.pop();
                  }
                : null,
            text: '완료',
            able: valid,
          );
        },
      )),
      body: NestedScrollView(
          headerSliverBuilder: (_, __) {
            return [
              const DefaultAppBar(
                isSliver: true,
                title: '환율 조건 설정',
              )
            ];
          },
          body: const CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _ExchangeForm(),
              )
            ],
          )),
    );
  }
}

class _ExchangeForm extends ConsumerWidget {
  const _ExchangeForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(tgExchangeFormProvider);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 34.h,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "현재 시간 기준 환율",
                style: SHFlowTextStyle.subTitle,
              ),
              DropDownButton(
                value: form.currency?.displayName,
                onChanged: (v) {
                  if (v != null) {
                    final currency =
                        ForeignCurrencyCategory.stringToEnum(value: v);
                    ref
                        .read(tgExchangeFormProvider.notifier)
                        .update(currency: currency);
                  }
                },
              )
            ],
          ),
          SizedBox(height: 32.h),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: const Color(0xFFCDE3F3),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${form.currency?.name} 1",
                  style: SHFlowTextStyle.labelBold,
                ),
                Text("KRW 1300", style: SHFlowTextStyle.labelBold),
              ],
            ),
          )
        ],
      ),
    );
  }
}
