import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notification/app.dart';
import 'package:push_notification/notification_service.dart';

void main() {
  // Garante que os pakages externos sejam carregados antes das widgets.
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        Provider<NotificationService>(create: (context) => NotificationService(),)
      ],
      child: const App(),
    )
  );
}
