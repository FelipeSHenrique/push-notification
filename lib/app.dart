import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notification/notification_service.dart';
import 'package:push_notification/routes.dart';
import 'package:push_notification/services/firebase_messaging_service.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    initilizeFirebaseMessaging();
    // Quando o aplicativo carregar ele vai ser se existe notificações
    checkNotification();
  }

  initilizeFirebaseMessaging() async {
    await Provider.of<FirebaseMessagingService>(context, listen: false).initilize();
  }

  checkNotification() async {
    await Provider.of<NotificationService>(context, listen: false).checkForNotification();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notification Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber
      ),
      routes: Routes.list,
      initialRoute: Routes.initial,
      navigatorKey: Routes.navigatorKey,
    );
  }
}
