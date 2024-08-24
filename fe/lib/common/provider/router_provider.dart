import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shinhan_flow/trigger/model/enum/product_property.dart';
import 'package:shinhan_flow/trigger/view/account_trigger_screen.dart';
import 'package:shinhan_flow/trigger/view/product_trigger_screen.dart';
import 'package:shinhan_flow/trigger/view/time_trigger_screen.dart';
import 'package:shinhan_flow/flow/view/trigger_category_screen.dart';
import 'package:shinhan_flow/flow/view/flow_init_screen.dart';
import 'package:shinhan_flow/home_screen.dart';

import '../../auth/view/login_screen.dart';
import '../../auth/view/sign_up_screen.dart';
import '../../trigger/view/exchange_trigger_screen.dart';

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
                  path: 'triggerCategory',
                  parentNavigatorKey: rootNavKey,
                  name: TriggerCategoryScreen.routeName,
                  builder: (context, state) {
                    return const TriggerCategoryScreen();
                  },
                  routes: [
                    GoRoute(
                        path: 'flowInit',
                        parentNavigatorKey: rootNavKey,
                        name: FlowInitScreen.routeName,
                        builder: (context, state) {
                          return const FlowInitScreen();
                        },
                        routes: [
                          GoRoute(
                              path: 'timeTrigger',
                              parentNavigatorKey: rootNavKey,
                              name: TimeTriggerScreen.routeName,
                              builder: (context, state) {
                                return const TimeTriggerScreen();
                              },
                              routes: []),
                          GoRoute(
                              path: 'accountTrigger',
                              parentNavigatorKey: rootNavKey,
                              name: AccountTriggerScreen.routeName,
                              builder: (context, state) {
                                return const AccountTriggerScreen();
                              },
                              routes: []),
                          GoRoute(
                              path: 'productTrigger',
                              parentNavigatorKey: rootNavKey,
                              name: ProductTriggerScreen.routeName,
                              builder: (context, state) {
                                return const ProductTriggerScreen();
                              },
                              routes: []),
                          GoRoute(
                              path: 'exchangeTrigger',
                              parentNavigatorKey: rootNavKey,
                              name: ExchangeTriggerScreen.routeName,
                              builder: (context, state) {
                                return const ExchangeTriggerScreen();
                              },
                              routes: []),
                        ]),
                  ]),
            ]),
      ]);
});
