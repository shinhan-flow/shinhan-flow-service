import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shinhan_flow/theme/text_theme.dart';
import 'package:shinhan_flow/trigger/model/enum/widget/account_property.dart';

import '../../common/component/default_appbar.dart';

class AccountTriggerScreen extends StatelessWidget {
  static String get routeName => 'account';

  const AccountTriggerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (_, __) {
            return [
              DefaultAppBar(
                title: '계좌 조건 설정',
                isSliver: true,
              )
            ];
          },
          body: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.all(25.r),
                sliver: SliverToBoxAdapter(
                  child: _AccountFormComponent(),
                ),
              )
            ],
          )),
    );
  }
}

class _AccountFormComponent extends StatelessWidget {
  const _AccountFormComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '계좌 조건',
          style: SHFlowTextStyle.subTitle,
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [],
        ),
      ],
    );
  }
}

class _AccountTriggerFilter extends StatelessWidget {
  final AccountProperty property;
  final bool isSelected;

  const _AccountTriggerFilter({
    super.key,
    required this.isSelected,
    required this.property,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: isSelected ? const Color(0xFFA3C9FF) : const Color(0xFFE4ECF9),
      ),
      child: Text(""),
    );
  }
}
