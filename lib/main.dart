import 'package:flutter/material.dart';
import 'signup_page.dart'; // Import your sign up page file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthcare',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Set the initial route to your sign up page
      initialRoute: '/signup',
      routes: {
        // Define routes for your pages
        '/signup': (context) => SignUpPage(),
        // Add routes for other pages like login, home, etc.
        // '/login': (context) => LoginPage(),
        // '/home': (context) => HomeScreen(),
      },
    );
  }
}
