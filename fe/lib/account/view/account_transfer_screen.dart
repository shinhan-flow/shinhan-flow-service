import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shinhan_flow/common/component/default_appbar.dart';
import 'package:shinhan_flow/common/component/text_input_form.dart';
import 'package:shinhan_flow/theme/text_theme.dart';

import '../../common/component/default_text_button.dart';
import '../../common/model/bank_model.dart';
import '../../common/model/default_model.dart';
import '../model/account_holder_model.dart';
import '../provider/account_holder_provider.dart';

class AccountTransferScreen extends StatefulWidget {
  static String get routeName => 'transfer';

  const AccountTransferScreen({super.key});

  @override
  State<AccountTransferScreen> createState() => _AccountTransferScreenState();
}

class _AccountTransferScreenState extends State<AccountTransferScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      onPanDown: (v) => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: NestedScrollView(
            // scrollBehavior: ScrollBehavior().copyWith(scrollbars: true, overscroll: false),
            headerSliverBuilder: (_, innerBoxIsScrolled) {
              log("innerBoxIsScrolled $innerBoxIsScrolled");

              return [
                DefaultAppBar(
                  isSliver: true,
                  title: '이체',
                )
              ];
            },
            body: CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: _TransferForm(),
                ),
                // SliverToBoxAdapter(
                //   child: CustomTextFormField(hintText: ''),
                // )
              ],
            )),
      ),
    );
  }
}

class _TransferForm extends ConsumerWidget {
  const _TransferForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(accountNoFormProvider, (prev, after){
      // ref.read(accounttrans);
    });
    return Padding(
      padding: EdgeInsets.all(24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "누구에게 이체하실건가요?",
            style: SHFlowTextStyle.subTitle,
          ),
          SizedBox(height: 12.h),
          AccountForm(), //0010337226851755
        ],
      ),
    );
  }
}

final accountNoFormProvider = StateProvider.autoDispose<String>((a) => '');

class AccountForm extends ConsumerStatefulWidget {
  const AccountForm({super.key});

  @override
  ConsumerState<AccountForm> createState() => _AccountFormState();
}

class _AccountFormState extends ConsumerState<AccountForm> {
  String accountNo = '';
  String? errorText;
  String? validText;

  @override
  Widget build(BuildContext context) {

    return CustomTextFormField(
      hintText: '계좌번호를 입력해주세요.',
      onChanged: (v) {
        setState(() {
          accountNo = v;
        });

        // ref.read(accountNoFormProvider.notifier).update((a) => v);
      },
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      side: SizedBox(
        width: 80.w,
        child: DefaultTextButton(
            onPressed: () async {


              final result = await ref
                  .read(accountHolderProvider(accountNo: accountNo).future);
              setState(() {
                if (result is ErrorModel) {
                  errorText = result.message;
                  validText = null;
                  // ref
                  //     .read(acTransferFormProvider.notifier)
                  //     .update(toAccount: '');
                } else {
                  final model = (result
                          as ResponseModel<BankBaseModel<AccountHolderModel>>)
                      .data!
                      .rec;

                  showDialog(
                      context: context,
                      builder: (_) {
                        return Align(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 5 * 4,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.w, vertical: 12.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                color: Colors.white),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                                  .read(accountNoFormProvider
                                                      .notifier)
                                                  .update((a) => accountNo);
                                              FocusScope.of(context).requestFocus(FocusNode());
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
    );
  }
}
