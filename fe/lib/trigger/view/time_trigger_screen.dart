import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shinhan_flow/common/component/default_appbar.dart';

import '../../common/component/table_calendar.dart';

class TimeTriggerScreen extends StatelessWidget {
  static String get routeName => 'timeTrigger';

  const TimeTriggerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (_, __) {
            return [
              DefaultAppBar(
                title: '시간 조건 설정',
                isSliver: true,
              )
            ];
          },
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: CalendarComponent(),
              )
            ],
          )),
    );
  }
}
