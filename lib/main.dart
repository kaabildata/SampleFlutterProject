import 'package:flutter/material.dart';

import 'ui/screens/home_screen.dart';
import 'ui/screens/login_screen.dart';
import 'ui/screens/registration_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen()
      },
    );
  }
}
