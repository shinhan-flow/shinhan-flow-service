import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shinhan_flow/common/component/default_appbar.dart';
import 'package:shinhan_flow/common/component/default_text_button.dart';

import '../../common/model/bank_model.dart';
import '../../common/model/default_model.dart';
import '../../theme/text_theme.dart';
import '../component/account_card.dart';
import '../model/account_model.dart';
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
                          },
                          scrollDirection: Axis.horizontal,
                        ));
                  },
                ),
              ),
            ],
          )),
    );
  }
}

class _TransactionHistoryComponent extends ConsumerWidget {
  const _TransactionHistoryComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverList.builder(itemBuilder: ((_, idx) {
      return TransactionHistoryCard();
    }));
  }
}

