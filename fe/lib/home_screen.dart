import 'dart:developer';

import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shinhan_flow/account/provider/account_holder_provider.dart';
import 'package:shinhan_flow/account/provider/account_provider.dart';
import 'package:shinhan_flow/account/provider/account_transaction_history_provider.dart';
import 'package:shinhan_flow/account/view/account_transaction_history_screen.dart';
import 'package:shinhan_flow/auth/provider/auth_provider.dart';
import 'package:shinhan_flow/auth/view/login_screen.dart';
import 'package:shinhan_flow/common/component/bottom_nav_button.dart';
import 'package:shinhan_flow/common/component/default_appbar.dart';
import 'package:shinhan_flow/common/component/default_text_button.dart';
import 'package:shinhan_flow/common/component/sliver_pagination_list_view.dart';
import 'package:shinhan_flow/common/component/text_input_form.dart';
import 'package:shinhan_flow/common/param/pagination_param.dart';
import 'package:shinhan_flow/exchange/provider/exchange_provider.dart';
import 'package:shinhan_flow/flow/view/flow_detail_screen.dart';
import 'package:shinhan_flow/flow/view/trigger_category_screen.dart';
import 'package:shinhan_flow/member/provider/member_provider.dart';
import 'package:shinhan_flow/member/view/member_info_screen.dart';
import 'package:shinhan_flow/product/model/product_loan_model.dart';
import 'package:shinhan_flow/product/model/product_saving_model.dart';
import 'package:shinhan_flow/product/provider/product_provider.dart';
import 'package:shinhan_flow/product/view/product_account_screen.dart';
import 'package:shinhan_flow/prompt/provider/prompt_provider.dart';
import 'package:shinhan_flow/prompt/view/prompt_screen.dart';
import 'package:shinhan_flow/theme/text_theme.dart';
import 'package:shinhan_flow/trigger/model/enum/foreign_currency_category.dart';
import 'package:shinhan_flow/util/util.dart';

import 'account/component/account_card.dart';
import 'account/model/account_model.dart';
import 'account/view/account_transfer_screen.dart';
import 'common/model/bank_model.dart';
import 'common/model/default_model.dart';
import 'exchange/model/exchange_rate_model.dart';
import 'flow/model/flow_model.dart';
import 'flow/provider/flow_provider.dart';
import 'member/model/member_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static String get routeName => 'home';

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavButton(
          child: DefaultTextButton(
              onPressed: () {
                context.pushNamed(TriggerCategoryScreen.routeName);
              },
              text: '플로우 만들기',
              able: true)),
      body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              DefaultAppBar(
                isSliver: true,
                leading: Row(
                  children: [
                    SizedBox(width: 15.w),
                    Image.asset(
                      AssetUtil.getAssetPath(name: 'logo', extension: 'png'),
                      width: 28.r,
                      height: 28.r,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "신한 플로우",
                      style: SHFlowTextStyle.appbar,
                    ),
                  ],
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(PromptScreen.routeName);
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text("AI"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(MemberInfoScreen.routeName);
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          AssetUtil.getAssetPath(
                            name: 'profile',
                            extension: 'png',
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Consumer(
                          builder: (BuildContext context, WidgetRef ref,
                              Widget? child) {
                            final result = ref.watch(memberInfoProvider);
                            if (result is LoadingModel) {
                              return Container();
                            } else if (result is ErrorModel) {
                              return Text("error");
                            }
                            final model =
                            (result as ResponseModel<MemberModel>);
                            return Text(
                              "${model.data!.name}님",
                              style: SHFlowTextStyle.subTitle,
                            );
                          },
                        ),
                        SizedBox(width: 15.w),
                      ],
                    ),
                  ),
                ],
              )
            ];
          },
          body: RefreshIndicator(
            onRefresh: () async {
              ref
                  .read(accountTransactionHistoryProvider.notifier)
                  .getHistories();
              ref.read(accountListProvider.notifier).getList();
              ref.read(flowProvider.notifier).paginate(
                  paginationParams:
                  const PaginationParam(nowPage: 0, perPage: 5),
                  forceRefetch: true);
              ref.read(exchangeRateProvider.notifier).getExchangeRates();
              ref.read(productSavingProvider.notifier).get();
            },
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      _AccountCardComponent(),
                      _FinanceInfoComponent(),
                      _FlowComponent(),
                      // PromptComponent(),
                    ],
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(
                    left: 28.w,
                    right: 28.w,
                    bottom: 12.h,
                  ),
                  sliver: DisposeSliverPaginationListView(
                    provider: flowProvider,
                    itemBuilder: (BuildContext _, int idx, Base pModel) {
                      final model = pModel as FlowModel;
                      return FlowCard.fromModel(
                        model: model,
                        onTap: () {
                          Map<String, String> path = {
                            'flowId': model.id.toString()
                          };
                          context.pushNamed(FlowDetailScreen.routeName,
                              pathParameters: path);
                        },
                      );
                    },
                    skeleton: Container(),
                    controller: _scrollController,
                    emptyWidget: Container(),
                  ),
                ),
                // SliverPadding(
                //   padding: EdgeInsets.only(
                //     left: 28.w,
                //     right: 28.w,
                //     bottom: 12.h,
                //   ),
                //   sliver: SliverList.separated(
                //     itemBuilder: (_, idx) => FlowCard(),
                //     separatorBuilder: (_, idx) => SizedBox(
                //       height: 12.h,
                //     ),
                //     itemCount: 10,
                //   ),
                // ),
              ],
            ),
          )),
    );
  }
}

final promptInputProvider = StateProvider.autoDispose((p) => '');

class PromptComponent extends ConsumerWidget {
  const PromptComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(promptInputProvider);
    return Column(
      children: [
        Container(
          child: CustomTextFormField(
            hintText: '프롬프트를 입력해주세요',
            onChanged: (v) {
              ref.read(promptInputProvider.notifier).update((p) => v);
            },
          ),
        ),
        DefaultTextButton(
            onPressed: () {
              final result = ref.read(promptProvider.future);
              if (result is ResponseModel<FlowDetailModel>) {
                log('result = ${result.toString()}');
              } else {
                log('result = ${result.toString()}');
              }
            },
            text: '입력',
            able: true),
      ],
    );
  }
}

class _AccountCardComponent extends ConsumerWidget {
  const _AccountCardComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // TextButton(
          //     onPressed: () {
          //       ref.read(authProvider.notifier).logout();
          //     },
          //     child: Text("임시 로그아웃")),
          // TextButton(
          //     onPressed: () {
          //       context.pushNamed(ProductAccountScreen.routeName);
          //     },
          //     child: Text("수시 입출금 상품")),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  context.pushNamed(AccountTransactionHistoryScreen.routeName);
                },
                child: Row(
                  children: [
                    Text(
                      '계좌',
                      style: SHFlowTextStyle.subTitle,
                    ),
                    // SizedBox(width: 7.w),
                    const Icon(
                      Icons.chevron_right,
                      color: Color(0xFF8D8D8D),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.pushNamed(AccountTransactionHistoryScreen.routeName);
                },
                child: Row(
                  children: [
                    Text(
                      '전체계좌보기',
                      style: SHFlowTextStyle.caption
                          .copyWith(color: const Color(0xFF747474)),
                    ),
                    // SizedBox(width: 7.w),
                    const Icon(
                      Icons.chevron_right,
                      color: Color(0xFF8D8D8D),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final result = ref.watch(accountListProvider);
              if (result is LoadingModel) {
                return CircularProgressIndicator();
              } else if (result is ErrorModel) {
                return Text("error");
              }
              final modelList = (result
              as ResponseModel<BankListBaseModel<AccountDetailModel>>)
                  .data!
                  .rec;
              if (modelList.isEmpty) {
                return GestureDetector(
                  onTap: () {
                    context.pushNamed(ProductAccountScreen.routeName);
                  },
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(15.r)),
                    child: Text(
                      '입출금 계좌 만들러가기',
                      style: SHFlowTextStyle.subTitle
                          .copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              final model = modelList.first;
              return GestureDetector(
                onTap: () {
                  context.pushNamed(AccountTransactionHistoryScreen.routeName);
                },
                child: AccountCard.fromModel(
                  model: model,
                  onTap: () {
                    context.pushNamed(AccountTransferScreen.routeName,
                        extra: model);
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class _FinanceInfoComponent extends ConsumerWidget {
  const _FinanceInfoComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Text(
              "금융 정보",
              style: SHFlowTextStyle.subTitle,
            ),
          ),
          SizedBox(height: 12.h),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              List<FinanceCard> cards = [];

              final memberResult = ref.watch(memberCreditScoreProvider);
              final exchangeResult = ref.watch(exchangeRateProvider);
              final loanResult = ref.watch(productLoanProvider);
              final savingResult = ref.watch(productSavingProvider);
              if (isLoading(
                  memberResult, exchangeResult, loanResult, savingResult)) {
                return CircularProgressIndicator();
              } else if (isError(
                  memberResult, exchangeResult, loanResult, savingResult)) {
                return Text("error");
              }
              final assetValue = (memberResult
              as ResponseModel<BankBaseModel<MemberCreditScoreModel>>)
                  .data!
                  .rec
                  .totalAssetValue;
              final asset = '${FormatUtil.formatNumber(assetValue)} 원';
              final currency =
              (exchangeResult as ResponseListModel<ExchangeRateModel>)
                  .data!
                  .firstWhere((e) => e.currency == CurrencyType.USD);
              final loanList = (loanResult
              as ResponseModel<BankListBaseModel<ProductLoanModel>>)
                  .data!
                  .rec;
              final savingList = (savingResult
              as ResponseModel<BankListBaseModel<ProductSavingModel>>)
                  .data!
                  .rec;

              loanList
                  .sort((l1, l2) => l1.interestRate.compareTo(l1.interestRate));
              savingList
                  .sort((l1, l2) => l1.interestRate.compareTo(l1.interestRate));
              final exchange =
                  '${FormatUtil.formatDouble(currency.exchangeRate)} 원';
              cards.add(FinanceCard(
                title: '총 자산',
                desc: asset,
              ));
              cards.add(FinanceCard(
                title: currency.currency.name,
                desc: exchange,
              ));
              if (loanList.isNotEmpty) {
                final desc =
                    '${FormatUtil.formatDouble(loanList.first.interestRate)} %';
                cards.add(FinanceCard(
                  title: loanList.first.accountName.toString(),
                  desc: desc,
                  color: const Color(0xFF1CB800),
                ));
              }
              if (savingList.isNotEmpty) {
                final desc =
                    '${FormatUtil.formatDouble(
                    savingList.first.interestRate)} %';
                cards.add(FinanceCard(
                  title: savingList.first.accountName.toString(),
                  desc: desc,
                  color: const Color(0xFFFF0000),
                ));
              }

              return Container(
                constraints: BoxConstraints.loose(Size(double.infinity, 100.r)),
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 28.w),
                    itemBuilder: (_, idx) {
                      return cards[idx];
                    },
                    separatorBuilder: (_, idx) =>
                        SizedBox(
                          width: 30.w,
                        ),
                    itemCount: cards.length),
              );
            },
          )
        ],
      ),
    );
  }

  bool isLoading(BaseModel memberResult, BaseModel exchangeResult,
      BaseModel loanResult, BaseModel savingResult) {
    return memberResult is LoadingModel ||
        exchangeResult is LoadingModel ||
        loanResult is LoadingModel ||
        savingResult is LoadingModel;
  }

  bool isError(BaseModel memberResult, BaseModel exchangeResult,
      BaseModel loanResult, BaseModel savingResult) {
    return memberResult is ErrorModel ||
        exchangeResult is ErrorModel ||
        loanResult is ErrorModel ||
        savingResult is ErrorModel;
  }
}

class FinanceCard extends StatelessWidget {
  final String title;
  final String desc;
  final Color? color;

  const FinanceCard({
    super.key,
    required this.title,
    required this.desc,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -1),
      child: Container(
        constraints: BoxConstraints.tight(Size(120.r, 90.r)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: Colors.white,
            border: Border.all(
                color: const Color(0xFFB5B5B5).withOpacity(.3), width: .5.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.25),
                offset: Offset(0, 4.h),
                blurRadius: 4.r,
              ),
            ]),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: SHFlowTextStyle.caption,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 7.h),
            Text(
              desc,
              style: SHFlowTextStyle.caption.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: color ?? Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class _FlowComponent extends ConsumerWidget {
  const _FlowComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                '플로우',
                style: SHFlowTextStyle.subTitle,
              ),
              // SizedBox(width: 7.w),
              const Icon(
                Icons.chevron_right,
                color: Color(0xFF8D8D8D),
              )
            ],
          ),

          // SizedBox(height: 12.h),
          // ListView.separated(
          //     itemBuilder: (_, idx) => FlowCard(),
          //     separatorBuilder: (_, idx) => SizedBox(height: 12.h,),
          //     itemCount: 10)
        ],
      ),
    );
  }
}

class FlowCard extends StatefulWidget {
  final int id;
  final int memberId;
  final String title;
  final String description;
  bool enable;
  final VoidCallback onTap;

  FlowCard({super.key,
    required this.memberId,
    required this.title,
    required this.description,
    required this.enable,
    required this.id,
    required this.onTap});

  factory FlowCard.fromModel(
      {required FlowModel model, required VoidCallback onTap}) {
    return FlowCard(
      memberId: model.memberId,
      title: model.title,
      description: model.description,
      enable: model.enable,
      id: model.id,
      onTap: onTap,
    );
  }

  @override
  State<FlowCard> createState() => _FlowCardState();
}

class _FlowCardState extends State<FlowCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.all(18.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color:
          widget.enable ? const Color(0xFF3F73FF) : const Color(0xFFEDEDED),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: SHFlowTextStyle.subTitle.copyWith(
                      color: widget.enable
                          ? Colors.white
                          : const Color(0xFF5F5F5F),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    widget.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: SHFlowTextStyle.labelSmall.copyWith(
                      color: widget.enable
                          ? Colors.white
                          : const Color(0xFF5F5F5F),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 24.w),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return Switch(
                  value: widget.enable,
                  onChanged: (v) async {
                    final result = await ref
                        .read(toggleFlowProvider(flowId: widget.id).future);
                    if (result is ErrorModel) {} else {
                      widget.enable = (result as ResponseModel<bool>).data!;
                    }
                    setState(() {});
                  },
                  activeColor: Colors.white,
                  activeTrackColor: Colors.black.withOpacity(0.25),
                  inactiveTrackColor: const Color(0xFFCBCFD7),
                  inactiveThumbColor: Colors.white,
                  trackOutlineColor:
                  WidgetStateProperty.all(Colors.transparent),
                  thumbIcon: WidgetStateProperty.all(const Icon(null)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
