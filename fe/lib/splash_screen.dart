import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:shinhan_flow/auth/view/login_screen.dart';
import 'package:shinhan_flow/permission_screen.dart';

import 'auth/provider/auth_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static String get routeName => 'splash';

  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late final Box<bool> permissionBox;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      startApp();
    });
  }

  Future<void> startApp() async {
    permissionBox = Hive.box('permission');
    final display = permissionBox.get('permission');
    if (display == null) {
      if (mounted) {
        context.goNamed(PermissionScreen.routeName);
      }
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref.read(authProvider.notifier).autoLogin(context: context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
