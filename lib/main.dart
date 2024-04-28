import 'package:flutter/material.dart';
import 'signup_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Healthcare',
      theme: ThemeData(
        primaryColor: Color(0xFF00E4DF),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/signup',
      routes: {
        '/signup': (context) => SignUpPage(),
        // '/login': (context) => LoginPage(),
        // '/home': (context) => HomeScreen(),
      },
    );
  }
}
