import 'package:flutter/material.dart';
import 'package:shinhan_flow/common/component/bottom_nav_button.dart';
import 'package:shinhan_flow/common/component/default_appbar.dart';

import '../../common/component/default_text_button.dart';

class ActionExchangeScreen extends StatelessWidget {
  static String get routeName => 'exchangeAction';

  const ActionExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavButton(
        child:
            DefaultTextButton(onPressed: () async {}, text: '완료', able: true),
      ),
      body: NestedScrollView(
          headerSliverBuilder: (_, __) {
            return [
              DefaultAppBar(
                title: '환전 행동',
                isSliver: true,
              )
            ];
          },
          body: CustomScrollView(
            slivers: [],
          )),
    );
  }
}
