import 'package:flutter/material.dart';
import 'signup_page.dart';

String? globalMobileNumber;

class CurrUserData {
  String? phone;
  String? name;
  int? height;
  String? gender;
  int? weight;
  int? age;
  int? peakFlowReading;
  bool? breathlessness;
  bool? beyond6Months;
  bool? haveCough;
  bool? ageSymptoms;
  bool? smokingBeyond10;
  bool? biomassSmoke;
  bool? intermittentPeriods;
}

CurrUserData? currData;

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
