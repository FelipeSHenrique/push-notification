import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:push_notification/routes.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class CustomNotification {
  final int id;
  final String? title;
  final String? body;
  final String? payload;

  CustomNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
}

class NotificationService {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails; // Detalhes da notificação no android

  //Inicializando as variaveis no metodo construtor
  NotificationService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupNotifications();
  }

  _setupNotifications() async {
    await _setupTimezone();//Iniciar o setup do timezone
    await _initializeNotification();
  }

  Future<void> _setupTimezone() async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();// Pega o timezone do sistema operacional
    tz.setLocalLocation(tz.getLocation(timeZoneName!));// Seta a timezone correta com base no timeZoneName
  }

  _initializeNotification() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android
      ),
      onSelectNotification: _onSelectNotification, // Quando o usuário clicar na notificação será disparado alguma ação
    );
  }

  _onSelectNotification(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      Navigator.of(Routes.navigatorKey!.currentContext!).pushReplacementNamed(payload);
    }
  }

  showNotification(CustomNotification notification) {
    androidDetails = const AndroidNotificationDetails(
      'lembrete_notifications_x',
      'Lembrete',
      channelDescription: 'Este canal é para lembrete',
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
    );

    localNotificationsPlugin.show(
      notification.id,
      notification.title,
      notification.body,
      NotificationDetails(
        android: androidDetails
      ),
      payload: notification.payload
    );
  }

  checkForNotification() async {
    // Verifica se existe uma notificação quando o App for aberto
    final details = await localNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      _onSelectNotification(details.payload);
    }
  }
}