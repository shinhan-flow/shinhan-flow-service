import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shinhan_flow/account/provider/account_holder_provider.dart';
import 'package:shinhan_flow/account/provider/account_provider.dart';
import 'package:shinhan_flow/common/component/bottom_nav_button.dart';
import 'package:shinhan_flow/common/component/default_appbar.dart';
import 'package:shinhan_flow/common/model/default_model.dart';

import '../../account/model/account_holder_model.dart';
import '../../account/model/account_model.dart';
import '../../common/component/default_text_button.dart';
import '../../common/component/text_input_form.dart';
import '../../common/model/bank_model.dart';
import '../../flow/param/trigger/trigger_param.dart';
import '../../flow/provider/widget/flow_form_provider.dart';
import '../../theme/text_theme.dart';
import '../../util/text_form_formatter.dart';
import '../provider/widget/exchange_action_form_provider.dart';
import '../provider/widget/transfer_action_form_provider.dart';

class ActionTransferScreen extends StatelessWidget {
  static String get routeName => 'transferAction';

  const ActionTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      onPanDown: (v) => FocusScope.of(context).unfocus(),
      child: Scaffold(
        bottomNavigationBar: BottomNavButton(
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final valid = ref.watch(acTransferFormProvider).valid;
              return DefaultTextButton(
                  onPressed: () async {
                    final action = ref.read(acTransferFormProvider);
                    log("action.toParam() = ${action.toParam()}");
                    ref
                        .read(flowFormProvider.notifier)
                        .addAction(action: action.toParam() as ActionBaseParam);
                    context.pop();
                  },
                  text: '완료',
                  able: valid);
            },
          ),
        ),
        body: NestedScrollView(
            headerSliverBuilder: (_, __) {
              return [
                const DefaultAppBar(
                  title: '송금 행동',
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
                const SliverToBoxAdapter(
                  child: _TransferForm(),
                )
              ],
            )),
      ),
    );
  }
}

class _TransferForm extends ConsumerStatefulWidget {
  const _TransferForm({super.key});

  @override
  ConsumerState<_TransferForm> createState() => _TransferFormState();
}

class _TransferFormState extends ConsumerState<_TransferForm> {
  String accountNo = '';
  String? errorText;
  String? validText;

  @override
  Widget build(BuildContext context) {
    // ref.watch(provider)
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "어디로 보내실 건가요?",
            style: SHFlowTextStyle.subTitle,
          ),
          SizedBox(height: 10.h),
          CustomTextFormField(
            hintText: '계좌번호를 입력해주세요.',
            onChanged: (v) {
              setState(() {
                accountNo = v;
              });
              // ref.read(acTransferFormProvider.notifier).update(toAccount: v);
            },
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            side: SizedBox(
              width: 80.w,
              child: DefaultTextButton(
                  onPressed: () async {
                    final result = await ref.read(
                        accountHolderProvider(accountNo: accountNo).future);
                    setState(() {
                      if (result is ErrorModel) {
                        errorText = result.message;
                        validText = null;
                        ref
                            .read(acTransferFormProvider.notifier)
                            .update(toAccount: '');
                      } else {
                        final model = (result as ResponseModel<
                                BankBaseModel<AccountHolderModel>>)
                            .data!
                            .rec;

                        showDialog(
                            context: context,
                            builder: (_) {
                              return Align(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 5 * 4,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24.w, vertical: 12.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.r),
                                      color: Colors.white),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        '보내실 분이 ${model.userName} 맞나요?',
                                        style: SHFlowTextStyle.subTitle,
                                      ),
                                      SizedBox(height: 24.h),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Expanded(
                                            child: DefaultTextButton(
                                                onPressed: () => context.pop(),
                                                text: '아니오',
                                                able: true),
                                          ),
                                          SizedBox(width: 12.w),
                                          Expanded(
                                            child: DefaultTextButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    validText = '계좌 인증 완료';
                                                    errorText = null;
                                                    ref
                                                        .read(
                                                            acTransferFormProvider
                                                                .notifier)
                                                        .update(
                                                            holder:
                                                                model.userName,
                                                            toAccount:
                                                                accountNo);
                                                    context.pop();
                                                  });
                                                },
                                                text: '예',
                                                able: true),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    });
                  },
                  text: '확인',
                  able: accountNo.isNotEmpty),
            ),
            errorText: errorText,
            validText: validText,
          ),
          SizedBox(height: 20.h),
          CustomTextFormField(
            hintText: '금액을 입력해주세요.',
            label: '금액',
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              NumberFormatter(),
            ],
            onChanged: (v) {
              ref.read(acTransferFormProvider.notifier).update(
                  amount: v.isNotEmpty ? int.parse(v.replaceAll(',', '')) : 0);
            },
          ),
        ],
      ),
    );
  }
}

class AccountDropDown extends ConsumerStatefulWidget {
  const AccountDropDown({super.key});

  @override
  ConsumerState<AccountDropDown> createState() => _AccountDropDownState();
}

class _AccountDropDownState extends ConsumerState<AccountDropDown> {
  AccountDetailModel? select;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((v) {});
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(acTransferFormProvider.select((s) => s.fromAccount));
    ref.watch(acExchangeFormProvider.select((s) => s.fromAccount));

    final result = ref.watch(accountListProvider);
    if (result is LoadingModel) {
      return const CircularProgressIndicator();
    } else if (result is ErrorModel) {
      return const Text("error");
    }
    final model =
        (result as ResponseModel<BankListBaseModel<AccountDetailModel>>)
            .data!
            .rec;
    final items = model
        .map((m) => DropdownMenuItem<AccountDetailModel>(
              value: m,
              child: getAccounts(m),
            ))
        .toList();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<AccountDetailModel>(
          isExpanded: true,
          style: SHFlowTextStyle.labelSmall.copyWith(color: Colors.black),
          items: items,
          onChanged: (AccountDetailModel? v) {
            setState(() {
              select = v;
              ref
                  .read(acTransferFormProvider.notifier)
                  .update(fromAccount: v?.accountNo);
              ref
                  .read(acExchangeFormProvider.notifier)
                  .update(fromAccount: v?.accountNo);
              log("value = $v");
            });
          },
          value: select ?? model[0],
          buttonStyleData: ButtonStyleData(
            padding: EdgeInsets.only(left: 16.w, right: 4.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: const Color(0xFF0057ff),
            ),
            height: 100.h,
            width: 120.w,
          ),
          iconStyleData: const IconStyleData(
            openMenuIcon: Icon(
              Icons.keyboard_arrow_up,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
          ),
          dropdownStyleData: DropdownStyleData(
              // scrollPadding: EdgeInsets.only(top: 4.h),
              // width: 85.w,
              offset: Offset(0, -4.h),
              elevation: 0,
              maxHeight: MediaQuery.of(context).size.height < 600.h
                  ? MediaQuery.of(context).size.height - 200.h
                  : 360.h,
              padding: EdgeInsets.zero,
              // EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: const Color(0xFF0057ff),
              )),
          menuItemStyleData: MenuItemStyleData(
            // overlayColor: WidgetStateProperty.all(const Color(0xFF404040)),
            height: 120.h,
            // padding: EdgeInsets.zero
            padding: EdgeInsets.symmetric(horizontal: 24.w),
          ),
        ),
      ),
    );
  }

  Column getAccounts(AccountDetailModel model) {
    final textStyle = SHFlowTextStyle.subTitle.copyWith(color: Colors.white);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(model.bankName, style: textStyle),
            Text(
              model.accountTypeName,
              style: textStyle,
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          model.accountNo,
          style: textStyle,
        ),
        Text(
          '${model.accountBalance} 원',
          textAlign: TextAlign.end,
          style: SHFlowTextStyle.body
              .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
