import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shinhan_flow/account/view/account_transaction_history_screen.dart';
import 'package:shinhan_flow/action/view/action_notification_screen.dart';
import 'package:shinhan_flow/flow/view/flow_detail_screen.dart';
import 'package:shinhan_flow/member/view/member_info_screen.dart';
import 'package:shinhan_flow/permission_screen.dart';
import 'package:shinhan_flow/product/view/product_account_screen.dart';
import 'package:shinhan_flow/splash_screen.dart';
import 'package:shinhan_flow/trigger/model/enum/product_property.dart';
import 'package:shinhan_flow/trigger/view/account_trigger_screen.dart';
import 'package:shinhan_flow/trigger/view/product_trigger_screen.dart';
import 'package:shinhan_flow/trigger/view/date_trigger_screen.dart';
import 'package:shinhan_flow/flow/view/trigger_category_screen.dart';
import 'package:shinhan_flow/flow/view/flow_init_screen.dart';
import 'package:shinhan_flow/home_screen.dart';

import '../../account/model/account_model.dart';
import '../../account/view/account_transfer_screen.dart';
import '../../action/view/action_exchange_screen.dart';
import '../../action/view/action_transfer_screen.dart';
import '../../auth/provider/auth_provider.dart';
import '../../auth/view/login_screen.dart';
import '../../auth/view/sign_up_screen.dart';
import '../../prompt/view/prompt_screen.dart';
import '../../trigger/view/exchange_trigger_screen.dart';
import '../../trigger/view/time_trigger_screen.dart';

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
  final provider = ref.read(tokenProvider);
  return GoRouter(
      initialLocation: '/splash',
      debugLogDiagnostics: true,
      navigatorKey: rootNavKey,
      refreshListenable: TokenProvider(ref: ref),
      routes: <RouteBase>[
        GoRoute(
          path: '/splash',
          parentNavigatorKey: rootNavKey,
          name: SplashScreen.routeName,
          builder: (context, state) {
            return const SplashScreen();
          },
        ),
        GoRoute(
          path: '/permission',
          parentNavigatorKey: rootNavKey,
          name: PermissionScreen.routeName,
          builder: (context, state) {
            return const PermissionScreen();
          },
        ),
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
            redirect: (_, state) => provider.redirectLogic(state),
            parentNavigatorKey: rootNavKey,
            name: HomeScreen.routeName,
            builder: (context, state) {
              return const HomeScreen();
            },
            routes: [
              GoRoute(
                path: 'prompt',
                parentNavigatorKey: rootNavKey,
                name: PromptScreen.routeName,
                builder: (context, state) {
                  return const PromptScreen();
                },
              ),
              GoRoute(
                path: 'memberInfo',
                parentNavigatorKey: rootNavKey,
                name: MemberInfoScreen.routeName,
                builder: (context, state) {
                  return const MemberInfoScreen();
                },
              ),
              GoRoute(
                  path: 'transactionHistory',
                  parentNavigatorKey: rootNavKey,
                  name: AccountTransactionHistoryScreen.routeName,
                  builder: (context, state) {
                    return const AccountTransactionHistoryScreen();
                  },
                  routes: [
                    GoRoute(
                      path: 'transfer',
                      parentNavigatorKey: rootNavKey,
                      name: AccountTransferScreen.routeName,
                      builder: (context, state) {
                        final account = state.extra as AccountDetailModel;
                        return AccountTransferScreen(
                          account: account,
                        );
                      },
                    ),
                  ]),
              GoRoute(
                path: 'productAccount',
                parentNavigatorKey: rootNavKey,
                name: ProductAccountScreen.routeName,
                builder: (context, state) {
                  return const ProductAccountScreen();
                },
              ),
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
                              path: 'dateTrigger',
                              parentNavigatorKey: rootNavKey,
                              name: DateTriggerScreen.routeName,
                              builder: (context, state) {
                                return const DateTriggerScreen();
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
                          GoRoute(
                              path: 'notificationAction',
                              parentNavigatorKey: rootNavKey,
                              name: ActionNotificationScreen.routeName,
                              builder: (context, state) {
                                return const ActionNotificationScreen();
                              },
                              routes: []),
                          GoRoute(
                              path: 'transferAction',
                              parentNavigatorKey: rootNavKey,
                              name: ActionTransferScreen.routeName,
                              builder: (context, state) {
                                return const ActionTransferScreen();
                              },
                              routes: []),
                          GoRoute(
                              path: 'exchangeAction',
                              parentNavigatorKey: rootNavKey,
                              name: ActionExchangeScreen.routeName,
                              builder: (context, state) {
                                return const ActionExchangeScreen();
                              },
                              routes: []),
                        ]),
                  ]),
              GoRoute(
                path: ':flowId',
                parentNavigatorKey: rootNavKey,
                name: FlowDetailScreen.routeName,
                builder: (context, state) {
                  final pathParameters = state.pathParameters;
                  final String flowId = pathParameters['flowId'] as String;
                  return FlowDetailScreen(
                    flowId: int.parse(flowId),
                  );
                },
              ),
            ]),
      ]);
});
