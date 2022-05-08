import 'package:flutter/material.dart';
import 'package:push_notification/home_page.dart';
import 'package:push_notification/notification_page.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list = <String, WidgetBuilder>{
    '/home': (_) => const HomePage(),
    '/notificacao': (_) => const NotificationPage(),
  };

  static String initial = '/home';

  // Permite acessar as rotas de qualquer parte do sistema
  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}