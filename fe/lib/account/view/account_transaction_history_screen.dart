import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shinhan_flow/account/provider/account_transaction_history_provider.dart';
import 'package:shinhan_flow/account/provider/widget/account_transaction_history_form_provider.dart';
import 'package:shinhan_flow/common/component/default_appbar.dart';
import 'package:shinhan_flow/common/component/default_text_button.dart';

import '../../common/model/bank_model.dart';
import '../../common/model/default_model.dart';
import '../../theme/text_theme.dart';
import '../component/account_card.dart';
import '../model/account_balance_model.dart';
import '../model/account_model.dart';
import '../model/account_transaction_history_model.dart';
import '../provider/account_provider.dart';

class AccountTransactionHistoryScreen extends StatelessWidget {
  static String get routeName => 'transactionHistory';

  const AccountTransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (_, __) {
            return [
              DefaultAppBar(
                isSliver: true,
                title: "입출금 거래내역",
              )
            ];
          },
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 24.h,
                ),
              ),
              SliverToBoxAdapter(
                child: Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    final result = ref.watch(accountListProvider);
                    if (result is LoadingModel) {
                      return CircularProgressIndicator();
                    } else if (result is ErrorModel) {
                      return Text("error");
                    }
                    final modelList = (result as ResponseModel<
                            BankListBaseModel<AccountDetailModel>>)
                        .data!
                        .rec;
                    final items = modelList
                        .map((m) => AccountCard.fromModel(
                              model: m,
                            ))
                        .toList();
                    // items.add(AccountCard.fromModel(model: model));
                    return CarouselSlider(
                        items: items,
                        options: CarouselOptions(
                          height: 150.h,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: false,
                          reverse: false,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.2,
                          onPageChanged:
                              (int index, CarouselPageChangedReason reason) {
                            log("index = $index , reason $reason");
                            ref
                                .read(accountTransactionHistoryFormProvider
                                    .notifier)
                                .update(accountNo: items[index].accountNo);
                          },
                          scrollDirection: Axis.horizontal,
                        ));
                  },
                ),
              ),
              _TransactionHistoryComponent(),
            ],
          )),
    );
  }
}

class _TransactionHistoryComponent extends ConsumerWidget {
  const _TransactionHistoryComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(accountTransactionHistoryFormProvider, (prev, after) {
      ref.read(accountTransactionHistoryProvider.notifier).getHistories();
    });
    final result = ref.watch(accountTransactionHistoryProvider);
    if (result is LoadingModel) {
      return SliverToBoxAdapter(
        child: CircularProgressIndicator(),
      );
    } else if (result is ErrorModel) {
      return SliverToBoxAdapter(
        child: Text("error"),
      );
    }

    final model = (result as ResponseModel<
            BankBaseModel<RecListModel<AccountTransactionHistoryModel>>>)
        .data!
        .rec;
    if (model.totalCount == '0') {
      return SliverFillRemaining(
        child: Center(
            child: Text(
          '거래 내역이 없습니다.',
          style: SHFlowTextStyle.title,
        )),
      );
    }

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      sliver: SliverList.builder(
        itemBuilder: ((_, idx) {
          return TransactionHistoryCard.fromModel(model: model.list[idx]);
        }),
        itemCount: int.parse(model.totalCount),
      ),
    );
  }
}
