import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_provider.g.dart';

final fcmTokenProvider = StateProvider<String?>((ref) => null);

@Riverpod(keepAlive: true)
class Notification extends _$Notification {
  FlutterLocalNotificationsPlugin? notificationsPlugin;

  //
  // @pragma('vm:entry-point')
  // Future<void> _firebaseMessagingBackgroundHandler(
  //     RemoteMessage message) async {
  //   // If you're going to use other Firebase services in the background, such as Firestore,
  //   // make sure you call `initializeApp` before using other Firebase services.
  //
  //   print("Handling a background message: ${message.messageId}");
  // }

  @override
  void build() async {
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
      // TODO: If necessary send token to application server.
      log('refresh fcm token ${fcmToken}');
      ref.read(fcmTokenProvider.notifier).update((state) => fcmToken);
      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    }).onError((err) {
      // Error getting token.
    });
  }

  void setNotificationPlugin(
      FlutterLocalNotificationsPlugin notificationsPlugin) {
    this.notificationsPlugin = notificationsPlugin;
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    log('설정');
  }

  FlutterLocalNotificationsPlugin? get getNotification => notificationsPlugin;
}
