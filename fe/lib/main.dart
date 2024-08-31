import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shinhan_flow/theme/text_theme.dart';

import 'auth/view/login_screen.dart';
import 'common/provider/provider_observer.dart';
import 'common/provider/router_provider.dart';
import 'firebase_options.dart';
import 'notification/provider/notification_provider.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void _foregroundRouting(NotificationResponse details) {
  rootNavKey.currentState?.context.goNamed(LoginScreen.routeName);
  log('_foregroundRouting = $details');
}

void _backgroundRouting(NotificationResponse details) {
  log('_backgroundRouting = $details');
}

Future<FlutterLocalNotificationsPlugin> _initLocalNotification() async {
  final FlutterLocalNotificationsPlugin localNotification =
      FlutterLocalNotificationsPlugin();

  /// Android 세팅
  const AndroidInitializationSettings initSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  /// IOS 세팅
  const initSettingsIOS = DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );

  const InitializationSettings initSettings = InitializationSettings(
    android: initSettingsAndroid,
    iOS: initSettingsIOS,
  );

  await localNotification.initialize(
    initSettings,
    onDidReceiveBackgroundNotificationResponse: _backgroundRouting,
    onDidReceiveNotificationResponse: _foregroundRouting,
  );

  return localNotification;
}

Future<void> getFcmToken(WidgetRef ref) async {
  String? token;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  log('FCM Token 가져오기');

  // 플랫폼 별 토큰 가져오기
  if (defaultTargetPlatform == TargetPlatform.iOS) {
    final apnToken = await messaging.getAPNSToken();
    print("apnToken : $apnToken");
    token = await messaging.getToken();
  } else {
    token = await messaging.getToken();
  }
  ref.read(fcmTokenProvider.notifier).update((state) => token);
  print("FCM Token: $token");
  log('FCM Token: $token');
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await initializeDateFormatting('ko');
  await Hive.initFlutter();
  await Hive.openBox<bool>('permission');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      observers: [
        CustomProviderObserver(),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    _notificationSetting();
    setupInteractedMessage();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getFcmToken(ref);
    });
  }

  void _notificationSetting() {
    _localNotificationSetting();
    _fcmSetting();
  }

  void _fcmSetting() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log("message.data= ${message.data}");

      RemoteNotification? notification = message.notification;

      // if (notification != null) {
      //   final flutterLocalNotificationsPlugin =
      //       ref.read(notificationProvider.notifier).getNotification;
      //
      //   await flutterLocalNotificationsPlugin?.show(
      //       notification.hashCode,
      //       notification.title,
      //       notification.body,
      //       const NotificationDetails(
      //         android: AndroidNotificationDetails(
      //           'high_importance_channel',
      //           'high_importance_notification',
      //           importance: Importance.max,
      //         ),
      //         // iOS: DarwinNotificationDetails(),
      //       ),
      //       payload: message.data['test_paremeter1']);
      //
      //   log('notification.title = ${notification.title}');
      //   log('notification.body = ${notification.body}');
      //   // log("수신자 측 메시지 수신");
      // }
    });
  }

  Future<void> setupInteractedMessage() async {
    // 앱을 껐을 때 알림을 클릭한 경우
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();

    log('remoteMessage = $message');
    if (message != null) {
      // 액션 부분 -> 파라미터는 message.data['test_parameter1'] 이런 방식으로...
      _handleMessage(message);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    rootNavKey.currentState?.context.goNamed(LoginScreen.routeName);
  }

  void _localNotificationSetting() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final notification = await _initLocalNotification();
      ref
          .read(notificationProvider.notifier)
          .setNotificationPlugin(notification);
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.read(routerProvider);

    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (_, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const <Locale>[
            Locale('ko'),
          ],
          title: 'Shinhan Flow',
          builder: (context, child) {
            return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child!);
          },
          theme: ThemeData(
            colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: Color(0xFF0057FF),
              onPrimary: Color(0xFF0057FF),
              secondary: Colors.white,
              onSecondary: Colors.white,
              error: Color(0xFFe21a1a),
              onError: Color(0xFFe21a1a),
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            }),
            // colorScheme: ColorScheme(background: Colors.white, brightness: null, primary: null, onPrimary: null, secondary: null, onSecondary: null, error: null, onError: null, onBackground: null, surface: null, onSurface: null,),
            fontFamily: 'Pretendard',
            inputDecorationTheme: InputDecorationTheme(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              // constraints: BoxConstraints.loose(Size(double.infinity, 58.h)),
              hintStyle:
                  SHFlowTextStyle.hint.copyWith(color: const Color(0xFF9a9a9a)),
              fillColor: const Color(0xFFf1f4f6),
              filled: true,
            ),
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  textStyle: WidgetStateProperty.all(SHFlowTextStyle.button),
                  foregroundColor:
                      WidgetStateProperty.all(const Color(0xFFf5f5f5)),
                  backgroundColor:
                      WidgetStateProperty.all(const Color(0xFF0057FF)),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        8.r,
                      ),
                    ),
                  ),
                  minimumSize: WidgetStateProperty.all(Size(0.w, 48.h)),
                  maximumSize:
                      WidgetStateProperty.all(Size(double.infinity, 48.h))),
            ),
          ),
          routerConfig: router,
        );
      },
      // child: const HomeScreen(), // LoginScreen(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
