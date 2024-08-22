import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shinhan_flow/theme/text_theme.dart';

class TriggerHistoryComponent extends StatelessWidget {
  const TriggerHistoryComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 28.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 24.w),
            child: Text(
              '내가 등록한 계좌 조건',
              style: SHFlowTextStyle.subTitle.copyWith(fontSize: 20.sp),
            ),
          ),
          _TriggerHistory(
            title: '입금',
            desc: '10,000이상',
          ),
        ],
      ),
    );
  }
}

class _TriggerHistory extends StatelessWidget {
  final String title;
  final String desc;

  const _TriggerHistory({super.key, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFdfdfdf)))),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: SHFlowTextStyle.body
                .copyWith(fontWeight: FontWeight.bold, fontSize: 18.sp),
          ),
          SizedBox(height: 6.h),
          Text(
            desc,
            style: SHFlowTextStyle.body.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
