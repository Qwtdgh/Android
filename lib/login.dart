import 'package:delivery/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:delivery/pages/login_page.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TheGorgeousLogin',
      //home: LoginPage(),
      initialRoute: "/",
      routes: {
        "/": (context) => LoginPage(),
        "/main": (context, {arguments}) => Main_Page(),
      },
    );
  }
}
