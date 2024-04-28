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
  double? pef;
  double? percentage;
  bool? breathlessness;
  bool? beyond6Months;
  bool? haveCough;
  bool? ageSymptoms;
  bool? smokingBeyond10;
  bool? biomassSmoke;
  bool? intermittentPeriods;

  CurrUserData() {
    phone = '0';
    name = '0';
    height = 0;
    gender = 'Male';
    weight = 0;
    age = 0;
    peakFlowReading = 0;
    pef = 0.0;
    percentage = 0.0;
    breathlessness = false;
    beyond6Months = false;
    haveCough = false;
    ageSymptoms = false;
    smokingBeyond10 = false;
    biomassSmoke = false;
    intermittentPeriods = false;
  }
}

CurrUserData currData = CurrUserData();

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
