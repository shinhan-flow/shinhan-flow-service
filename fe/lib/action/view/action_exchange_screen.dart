import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shinhan_flow/action/provider/widget/exchange_action_form_provider.dart';
import 'package:shinhan_flow/common/component/bottom_nav_button.dart';
import 'package:shinhan_flow/common/component/default_appbar.dart';
import 'package:shinhan_flow/common/component/text_input_form.dart';
import 'package:shinhan_flow/common/model/bank_model.dart';
import 'package:shinhan_flow/common/model/default_model.dart';
import 'package:shinhan_flow/exchange/model/exchange_rate_model.dart';
import 'package:shinhan_flow/exchange/provider/exchange_provider.dart';
import 'package:shinhan_flow/theme/text_theme.dart';

import '../../common/component/default_text_button.dart';
import '../../common/component/drop_down_button.dart';
import '../../trigger/model/enum/foreign_currency_category.dart';
import '../../util/text_form_formatter.dart';
import 'action_transfer_screen.dart';

class ActionExchangeScreen extends StatelessWidget {
  static String get routeName => 'exchangeAction';

  const ActionExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      onPanDown: (v) => FocusScope.of(context).unfocus(),
      child: Scaffold(
        bottomNavigationBar: BottomNavButton(
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final valid = ref.watch(acExchangeFormProvider).valid;
              log("valid = $valid");
              return DefaultTextButton(
                  onPressed: () async {}, text: '완료', able: valid);
            },
          ),
        ),
        body: NestedScrollView(
            headerSliverBuilder: (_, __) {
              return [
                DefaultAppBar(
                  title: '환전 행동',
                  isSliver: true,
                )
              ];
            },
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: const AccountDropDown(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.h),
                    child: const _ExchangeForm(),
                  ),
                ),
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
    final form = ref.watch(acExchangeFormProvider);
    final result = ref.watch(exchangeRateProvider);
    if (result is LoadingModel) {
      return CircularProgressIndicator();
    } else if (result is ErrorModel) {}
    final model =
        (result as ResponseModel<BankListBaseModel<ExchangeRateModel>>)
            .data!
            .rec;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "얼마나 환전하실 건가요",
              style: SHFlowTextStyle.subTitle,
            ),
            DropDownButton(
              value: form.currency.displayName,
              onChanged: (v) {
                if (v != null) {
                  final currency = CurrencyType.stringToEnum(value: v);
                  ref
                      .read(acExchangeFormProvider.notifier)
                      .update(currency: currency);
                }
              },
            )
          ],
        ),
        SizedBox(height: 12.h),
        CustomTextFormField(
          hintText: '환전하실 금액을 입력해주세요.',
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            NumberFormatter(),
          ],
          onChanged: (v) {
            if (v.isNotEmpty) {
              ref
                  .read(acExchangeFormProvider.notifier)
                  .update(amount: int.parse(v.replaceAll(',', '')));
            } else {
              ref.read(acExchangeFormProvider.notifier).update(amount: 0);
            }
          },
        ),
        // SizedBox(height: 20.h),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       '예상 환전 금액',
        //       style: SHFlowTextStyle.subTitle,
        //     ),
        //     Text(
        //       '1300',
        //       style: SHFlowTextStyle.subTitle,
        //     ),
        //   ],
        // )
      ],
    );
  }
}
