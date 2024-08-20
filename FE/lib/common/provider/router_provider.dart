import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shinhan_flow/flow/view/flow_category_screen.dart';
import 'package:shinhan_flow/home_screen.dart';

import '../../auth/view/login_screen.dart';
import '../../auth/view/sign_up_screen.dart';

final GlobalKey<NavigatorState> rootNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavKey = GlobalKey<NavigatorState>();

class DialogPage<T> extends Page<T> {
  static String get routeName => 'test';

  final Widget child;

  const DialogPage({required this.child, super.key});

  @override
  Route<T> createRoute(BuildContext context) => DialogRoute<T>(
        context: context,
        settings: this,
        barrierDismissible: false,
        builder: (context) => Material(
          color: Colors.transparent,
          child: child,
        ),
      );
}

final routerProvider = Provider<GoRouter>((ref) {
  // final provider = ref.read(tokenProvider);
  return GoRouter(
      initialLocation: '/home',
      debugLogDiagnostics: true,
      navigatorKey: rootNavKey,
      // refreshListenable: TokenProvider(ref: ref),
      routes: <RouteBase>[
        GoRoute(
            path: '/login',
            parentNavigatorKey: rootNavKey,
            name: LoginScreen.routeName,
            builder: (context, state) {
              return const LoginScreen();
            },
            routes: [
              GoRoute(
                path: 'signup',
                parentNavigatorKey: rootNavKey,
                name: SignUpScreen.routeName,
                builder: (context, state) {
                  return const SignUpScreen();
                },
              ),
            ]),
        GoRoute(
            path: '/home',
            parentNavigatorKey: rootNavKey,
            name: HomeScreen.routeName,
            builder: (context, state) {
              return const HomeScreen();
            },
            routes: [
              GoRoute(
                  path: 'flowCategory',
                  parentNavigatorKey: rootNavKey,
                  name: FlowCategoryScreen.routeName,
                  builder: (context, state) {
                    return const FlowCategoryScreen();
                  },
                  routes: []),
            ]),
      ]);
});
