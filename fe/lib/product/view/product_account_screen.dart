import 'dart:convert';
import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shinhan_flow/account/param/account_param.dart';
import 'package:shinhan_flow/account/provider/account_provider.dart';
import 'package:shinhan_flow/action/provider/widget/transfer_action_form_provider.dart';
import 'package:shinhan_flow/common/component/default_appbar.dart';
import 'package:shinhan_flow/common/component/default_flashbar.dart';
import 'package:shinhan_flow/common/component/default_text_button.dart';
import 'package:shinhan_flow/common/component/text_input_form.dart';
import 'package:shinhan_flow/common/model/default_model.dart';
import 'package:shinhan_flow/product/provider/product_provider.dart';
import 'package:shinhan_flow/theme/text_theme.dart';

import '../../common/model/entity_enum.dart';
import '../../util/text_form_formatter.dart';
import '../model/product_account_model.dart';

class ProductAccountScreen extends StatelessWidget {
  static String get routeName => 'productAccount';

  const ProductAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (_, __) {
            return [
              DefaultAppBar(
                isSliver: true,
                title: '수시 입출금 상품',
              )
            ];
          },
          body: CustomScrollView(
            slivers: [
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final result = ref.watch(productAccountProvider);
                  if (result is LoadingModel) {
                    return SliverToBoxAdapter(
                        child: const CircularProgressIndicator());
                  } else if (result is ErrorModel) {
                    return const SliverToBoxAdapter(child: Text("에러"));
                  }
                  final modelList =
                      (result as ResponseModel<List<ProductBankAccountModel>>)
                          .data!;
                  return SliverPadding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                    sliver: SliverList.builder(
                        itemCount: modelList.length,
                        itemBuilder: (_, idx) {
                          if (modelList[idx].products.isEmpty) {
                            return Container();
                          }

                          return _BankProductComponent.fromModel(
                              model: modelList[idx]);
                        }),
                  );
                },
              ),
              // SliverToBoxAdapter(
              //   child: Consumer(
              //     builder:
              //         (BuildContext context, WidgetRef ref, Widget? child) {
              //       final result = ref.watch(productAccountProvider);
              //       if (result is LoadingModel) {
              //         return const CircularProgressIndicator();
              //       } else if (result is ErrorModel) {
              //         return Text("에러");
              //       }
              //       final modelList =
              //           (result as ResponseModel<List<ProductBankAccountModel>>)
              //               .data!;
              //
              //       return ListView.builder(
              //         shrinkWrap: true,
              //         physics: const NeverScrollableScrollPhysics(),
              //         padding: EdgeInsets.symmetric(
              //             horizontal: 24.w, vertical: 16.h),
              //         itemBuilder: (_, idx) {
              //           if (modelList[idx].products.isEmpty) {
              //             return Container();
              //           }
              //           return _BankProductComponent.fromModel(
              //               model: modelList[idx]);
              //         },
              //         itemCount: modelList.length,
              //       );
              //     },
              //   ),
              // ),
            ],
          )),
    );
  }
}

class _BankProductComponent extends ConsumerWidget {
  final BankType bankType;
  final List<ProductAccountModel> products;

  const _BankProductComponent({
    super.key,
    required this.bankType,
    required this.products,
  });

  factory _BankProductComponent.fromModel(
      {required ProductBankAccountModel model}) {
    log(" ${model.bankType}model. length ${model.products.length}");
    return _BankProductComponent(
      bankType: model.bankType,
      products: model.products,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          bankType.bankName,
          style: SHFlowTextStyle.subTitle,
        ),
        SizedBox(height: 12.h),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (_, idx) {
            return _ProductCard.fromModel(model: products[idx]);
          },
          itemCount: products.length,
        )
      ],
    );
  }
}

class _ProductCard extends ConsumerWidget {
  final String accountTypeUniqueNo;
  final String bankCode;
  final String bankName;
  final String accountTypeCode;
  final String accountTypeName;
  final String accountName;
  final String accountDescription;
  final String accountType;

  const _ProductCard({
    super.key,
    required this.accountTypeUniqueNo,
    required this.bankCode,
    required this.bankName,
    required this.accountTypeCode,
    required this.accountTypeName,
    required this.accountName,
    required this.accountDescription,
    required this.accountType,
  });

  factory _ProductCard.fromModel({required ProductAccountModel model}) {
    return _ProductCard(
      accountTypeUniqueNo: model.accountTypeUniqueNo,
      bankCode: model.bankCode,
      bankName: model.bankName,
      accountTypeCode: model.accountTypeCode,
      accountTypeName: model.accountTypeName,
      accountName: model.accountName,
      accountDescription: model.accountDescription,
      accountType: model.accountType,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) {
              return Align(
                child: Container(
                  width: MediaQuery.of(context).size.width / 5 * 4,
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: Colors.white),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '$bankName 입출금 계좌를 생성하시겠습니까?',
                        style: SHFlowTextStyle.subTitle,
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: DefaultTextButton(
                                onPressed: () => context.pop(),
                                text: '취소하기',
                                able: true),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: DefaultTextButton(
                                onPressed: () async {
                                  final param = AccountCreateParam(
                                      accountTypeUniqueNo: accountTypeUniqueNo);
                                  final result = await ref.read(
                                      createAccountProvider(param: param)
                                          .future);
                                  if (result is ErrorModel) {
                                    if (context.mounted) {
                                      FlashUtil.showFlash(
                                        context,
                                        '계좌 생성을 실패하였습니다!',
                                        textColor: const Color(0xFFe21a1a),
                                      );
                                    }
                                  } else {
                                    if (context.mounted) {
                                      FlashUtil.showFlash(
                                        context,
                                        '계좌 생성을 성공하였습니다!',
                                        textColor: const Color(0xFF49B7FF),
                                      );
                                    }
                                  }
                                  if (context.mounted) {
                                    context.pop();
                                  }
                                },
                                text: '생성하기',
                                able: true),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.r, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: const Color(0xFFEDEDED),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                accountName,
                style: SHFlowTextStyle.subTitle,
              ),
              SizedBox(height: 12.h),
              Text(
                accountDescription,
                style: SHFlowTextStyle.subTitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
