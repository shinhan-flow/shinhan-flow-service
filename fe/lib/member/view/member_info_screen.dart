import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shinhan_flow/account/component/account_card.dart';
import 'package:shinhan_flow/common/component/default_appbar.dart';
import 'package:shinhan_flow/member/provider/member_provider.dart';
import 'package:shinhan_flow/product/view/product_account_screen.dart';
import 'package:shinhan_flow/theme/text_theme.dart';
import 'package:shinhan_flow/util/util.dart';

import '../../common/model/bank_model.dart';
import '../../common/model/default_model.dart';
import '../model/member_model.dart';

class MemberInfoScreen extends StatelessWidget {
  static String get routeName => 'memberInfo';

  const MemberInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (_, __) {
            return [
              DefaultAppBar(
                title: '마이페이지',
                isSliver: true,
              ),
            ];
          },
          body: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    final result = ref.watch(memberInfoProvider);
                    final model = (result as ResponseModel<MemberModel>).data!;

                    return Column(
                      children: [
                        _ProfileComponent(
                          name: model.name,
                          email: model.email,
                        ),
                        _CreditCard(
                          createdAt: model.createdAt,
                        ),
                        InfoListComponent()
                      ],
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}

class _ProfileComponent extends StatelessWidget {
  final String name;
  final String email;

  const _ProfileComponent({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 40.r,
            backgroundColor: Colors.white,
            foregroundImage: AssetImage(
              AssetUtil.getAssetPath(
                name: 'bigProfile',
                extension: 'png',
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: SHFlowTextStyle.subTitle,
              ),
              Text(
                email,
                style: SHFlowTextStyle.caption
                    .copyWith(color: Colors.black.withOpacity(.5)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CreditCard extends ConsumerWidget {
  final String createdAt;

  const _CreditCard({super.key, required this.createdAt});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(memberCreditScoreProvider);
    if (result is LoadingModel) {
      return const CircularProgressIndicator();
    } else if (result is ErrorModel) {
      return Text("error");
    }
    final rating =
        (result as ResponseModel<BankBaseModel<MemberCreditScoreModel>>)
            .data!
            .rec
            .ratingName;
    final day = DateTime.now().difference(DateTime.parse(createdAt)).inDays;
    final withDayText = RichText(
        text: TextSpan(children: [
      TextSpan(
          text: '신한은행과 함께한지 ',
          style: SHFlowTextStyle.caption.copyWith(color: Colors.black)),
      TextSpan(
          text: '$day일째 ',
          style:
              SHFlowTextStyle.caption.copyWith(color: const Color(0xFFF88787))),
      TextSpan(
          text: '되는 날이에요.',
          style: SHFlowTextStyle.caption.copyWith(color: Colors.black)),
    ]));

    final creditScoreText = RichText(
        text: TextSpan(children: [
      TextSpan(
          text: '오늘의 신용 점수는 ',
          style: SHFlowTextStyle.caption.copyWith(color: Colors.black)),
      TextSpan(
          text: '$rating 등급 ',
          style:
              SHFlowTextStyle.caption.copyWith(color: const Color(0xFF46A777))),
      TextSpan(
          text: '이에요.',
          style: SHFlowTextStyle.caption.copyWith(color: Colors.black)),
    ]));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 12.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: const Color(0xFF000000).withOpacity(0.25),
                  offset: Offset(0, 4.h),
                  blurRadius: 4.r)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            withDayText,
            SizedBox(height: 15.h),
            creditScoreText,
          ],
        ),
      ),
    );
  }
}

class InfoListComponent extends StatelessWidget {
  InfoListComponent({super.key});

  Map<String, String> list = {
    '내 계좌 목록': '',
    '금융 상품 조회': ProductAccountScreen.routeName,
    '로그아웃': '',
  };

  @override
  Widget build(BuildContext context) {
    final cards = list.entries.map((e) {
      return GestureDetector(
        onTap: e.value.isNotEmpty
            ? () {
                context.pushNamed(e.value);
              }
            : null,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: const Color(0xFFCECECE).withOpacity(.2),
              ),
            ),
          ),
          child: Text(
            e.key,
            style: SHFlowTextStyle.subTitle,
          ),
        ),
      );
    }).toList();
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, idx) {
        return cards[idx];
      },
      itemCount: cards.length,
    );
  }
}
