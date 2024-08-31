import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shinhan_flow/auth/view/login_screen.dart';
import 'package:shinhan_flow/common/component/bottom_nav_button.dart';
import 'package:shinhan_flow/common/component/default_appbar.dart';
import 'package:shinhan_flow/common/component/text_input_form.dart';
import 'package:shinhan_flow/common/model/bank_model.dart';
import 'package:shinhan_flow/exchange/model/exchange_rate_model.dart';
import 'package:shinhan_flow/exchange/provider/exchange_provider.dart';
import 'package:shinhan_flow/flow/provider/widget/exchange_trigger_form_provider.dart';
import 'package:shinhan_flow/theme/text_theme.dart';
import 'package:shinhan_flow/trigger/model/enum/foreign_currency_category.dart';

import '../../common/component/default_text_button.dart';
import '../../common/component/drop_down_button.dart';
import '../../common/model/default_model.dart';
import '../../flow/param/trigger/trigger_param.dart';
import '../../flow/provider/widget/flow_form_provider.dart';

class ExchangeTriggerScreen extends ConsumerWidget {
  static String get routeName => 'exchange';

  const ExchangeTriggerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: FocusScope.of(context).requestFocus,
      onPanDown: (v) => FocusScope.of(context).requestFocus(),
      child: Scaffold(
        bottomNavigationBar: BottomNavButton(child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final valid = ref.watch(tgExchangeFormProvider).valid;

            return DefaultTextButton(
              onPressed: valid
                  ? () {
                      final trigger = ref.read(tgExchangeFormProvider);
                      ref.read(flowFormProvider.notifier).addTrigger(
                          trigger: trigger.toParam() as TriggerBaseParam);
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
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: _ExchangeForm(),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: CustomTextFormField(
                      label: '조건 환율',
                      hintText: '환전하고 싶은 환율을 입력해주세요.',
                      keyboardType: TextInputType.number,
                      onChanged: (v) {
                        ref
                            .read(tgExchangeFormProvider.notifier)
                            .update(exRate: double.parse(v));
                      },
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class _ExchangeForm extends ConsumerWidget {
  const _ExchangeForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double exchangeRate = 0;
    final form = ref.watch(tgExchangeFormProvider);
    final result = ref.watch(exchangeRateProvider);
    if (result is LoadingModel) {
      return const CircularProgressIndicator();
    }
    if (result is ResponseListModel<ExchangeRateModel>) {
      final model = result.data!.firstWhere((e) => e.currency == form.currency);
      exchangeRate = model.exchangeRate;
    }

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
                    final currency = CurrencyType.stringToEnum(value: v);
                    ref.read(tgExchangeFormProvider.notifier).update(
                          currency: currency,
                        );
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
                Text("KRW $exchangeRate", style: SHFlowTextStyle.labelBold),
              ],
            ),
          )
        ],
      ),
    );
  }
}
