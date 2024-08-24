import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shinhan_flow/auth/view/login_screen.dart';
import 'package:shinhan_flow/common/component/bottom_nav_button.dart';
import 'package:shinhan_flow/common/component/default_text_button.dart';
import 'package:shinhan_flow/home_screen.dart';

class PermissionScreen extends StatelessWidget {
  static String get routeName => 'permission';

  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavButton(
        child: DefaultTextButton(
            onPressed: () async {
              await Permission.notification.request();
              context.goNamed(HomeScreen.routeName);
            },
            text: '시작하기',
            able: true),
      ),
      body: Column(
        children: [Text('알람 허용')],
      ),
    );
  }
}
