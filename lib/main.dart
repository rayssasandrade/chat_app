import 'package:chat_app/core/services/notification/chat_notification_service.dart';
import 'package:chat_app/pages/auth_or_app_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Map<int, Color> colorCodes = {
      50: Color.fromRGBO(147, 205, 72, .1),
      100: Color.fromRGBO(147, 205, 72, .2),
      200: Color.fromRGBO(147, 205, 72, .3),
      300: Color.fromRGBO(147, 205, 72, .4),
      400: Color.fromRGBO(147, 205, 72, .5),
      500: Color.fromRGBO(147, 205, 72, .6),
      600: Color.fromRGBO(147, 205, 72, .7),
      700: Color.fromRGBO(147, 205, 72, .8),
      800: Color.fromRGBO(147, 205, 72, .9),
      900: Color.fromRGBO(147, 205, 72, 1),
    };

    MaterialColor myColor = MaterialColor(0xFF0B1D39, colorCodes);
    MaterialColor secondyColor = MaterialColor(0xFF485A88, colorCodes);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatNotificationService(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: secondyColor,
          accentColor: myColor,
        ),
        home: const AuthOrAppPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
