import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shinhan_flow/auth/view/login_screen.dart';
import 'package:shinhan_flow/common/component/bottom_nav_button.dart';
import 'package:shinhan_flow/common/component/default_appbar.dart';
import 'package:shinhan_flow/common/component/default_text_button.dart';
import 'package:shinhan_flow/home_screen.dart';
import 'package:shinhan_flow/theme/text_theme.dart';

class PermissionScreen extends StatefulWidget {
  static String get routeName => 'permission';

  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  late final Box<bool> permissionBox;

  @override
  void initState() {
    super.initState();
    permissionBox = Hive.box('permission');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: '권한 설정',
      ),
      bottomNavigationBar: BottomNavButton(
        child: DefaultTextButton(
            onPressed: () async {
              final permissionStatus = await Permission.notification.request();

              await permissionBox.put('permission', false);
              if (context.mounted) {
                context.goNamed(LoginScreen.routeName);
              }
            },
            text: '시작하기',
            able: true),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.notifications,
                  size: 32.r,
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "알림 허용 (선택)",
                        style: SHFlowTextStyle.subTitle,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Flow 기능을 원활하게 사용하기 위해서는 알림 허용이 필요합니다.',
                        style: SHFlowTextStyle.form,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
