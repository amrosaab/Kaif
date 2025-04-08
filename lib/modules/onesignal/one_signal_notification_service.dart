import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flux_firebase/index.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../models/entities/fstore_notification_item.dart';
import '../../services/notification/notification_service.dart';

class OneSignalNotificationService extends NotificationService {
  // final _instance = OneSignal;
  final String appID;

  OneSignalNotificationService({required this.appID}) {
    OneSignal.initialize(appID);

  }

  @override
  void disableNotification() {
    OneSignal.Notifications.requestPermission(false);
  }

  @override
  void enableNotification() {
    OneSignal.Notifications.requestPermission(true);
  }

  @override
  Future<void> init({
    String? externalUserId,
    required NotificationDelegate notificationDelegate,
  }) async {


    // Future.delayed(Duration(seconds: 30),() async {
    //   print("maxccxcx${await FirebaseMessaging.instance.getToken()}");
    //
    // });

    // OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    //
    // OneSignal.Debug.setAlertLevel(OSLogLevel.none);


    OneSignal.LiveActivities.setupDefault();
    // OneSignal.LiveActivities.setupDefault(options: new LiveActivitySetupOptions(enablePushToStart: false, enablePushToUpdate: true));

    // AndroidOnly stat only
    // OneSignal.Notifications.removeNotification(1);
    // OneSignal.Notifications.removeGroupedNotifications("group5");

    // OneSignal.Notifications.clearAll();
    OneSignal.Notifications.requestPermission(true);
    OneSignal.User.pushSubscription.addObserver((state) {
      print(OneSignal.User.pushSubscription.optedIn);
      print("pushub${OneSignal.User.pushSubscription.id}");
      print(OneSignal.User.pushSubscription.token);
      print(state.current.jsonRepresentation());
    });

    OneSignal.User.addObserver((state) {
      var userState = state.jsonRepresentation();
      print('OneSignal user changed: $userState');
    });

    OneSignal.Notifications.addPermissionObserver((state) {
      print("Has permission " + state.toString());
    });
    await OneSignal.Notifications.requestPermission(true);

    OneSignal.User.pushSubscription.optIn();


    // OneSignal.login(externalUserId ?? '');
    delegate = notificationDelegate;
    _setupOnMessageOpenedApp();
    _setupOnMessage();
  }

  void _setupOnMessageOpenedApp() {
    OneSignal.Notifications.addClickListener(( result) {
      final data = result.notification;
      print("aAaAaAa${data.additionalData}");
      delegate.onMessageOpenedApp(FStoreNotificationItem(
        id: data.notificationId,
        title: data.title ?? '',
        body: data.body ?? '',
        additionalData: data.additionalData,
        date: DateTime.now(),
      ));
    });
  }

  void _setupOnMessage() {

    OneSignal.Notifications.addForegroundWillDisplayListener((
            ( result) {
          print("cvvcvvvc${result}");
          final data = result.notification;
          //
          // _instance.completeNotification(
          //   result.notification.notificationId,
          //   false,
          // );
          result.preventDefault();

          result.notification.display();
          // flutterLocalNotificationsPlugin.show(
          //   data.hashCode,
          //   data.title,
          //   data.body,
          //   payload: jsonEncode(data.additionalData),
          //   NotificationDetails(
          //     android: AndroidNotificationDetails(
          //       channel.id,
          //       channel.name,
          //       channelDescription: channel.description,
          //       icon:
          //           data.largeIcon ?? data.smallIcon ?? 'ic_stat_onesignal_default',
          //     ),
          //     iOS: const DarwinNotificationDetails(),
          //   ),
          // );
        }));
  }

  @override
  void setExternalId(String? userId) async {
    if (userId != null) {
      await OneSignal.login(userId);
    }
  }

  @override
  void removeExternalId() async {
    OneSignal.logout();
  }
}
