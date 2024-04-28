import 'package:flutter/material.dart';
import 'package:hcare/q1_page.dart';
import 'package:hcare/signup_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hcare/home_page.dart';

import 'main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Function to handle login button press
  void _handleLogin(BuildContext context) async {
    // Get input values
    String phone = _phoneController.text;
    String password = _passwordController.text;

    // Validate input fields (You can add more validation)
    if (phone.isEmpty || password.isEmpty) {
      _showErrorDialog(context, "Please fill in all fields!");
      return;
    } else if (phone.length != 10) {
      _showErrorDialog(context, "Please enter a valid mobile number");
      return;
    }

    // Check credentials in the database
    int isAuthenticated = await _checkCredentials(phone, password);

    if (isAuthenticated == 0) {
      globalMobileNumber = phone;
      currData?.phone = phone;
      // Navigate to home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Question1Page()),
      );
    } else if (isAuthenticated == 1) {
      _showErrorDialog(context, "User does not exists, Log In");
    } else {
      _showErrorDialog(context, "Wrong Password.");
    }
  }

  // Function to check credentials in the database
  Future<int> _checkCredentials(String phone, String password) async {
    // Open the database
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'user_database.db'),
    );

    // Query the database for user with matching phone and password
    List<Map<String, dynamic>> result = await database.query(
      'users',
      where: 'phone = ?',
      whereArgs: [phone],
    );

    // Check if user exists
    if (result.isEmpty) {
      return 1; // User does not exist
    }
    // Check if the password matches
    String storedPassword = result[0]['password'];
    if (storedPassword != password) {
      return 2; // Password does not match
    }

    // User exists and password matches
    return 0;
  }

  // Function to show error SnackBar
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Try again :("),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF00E4DF)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          const Padding(padding: EdgeInsets.all(20)),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Image.asset(
                'assets/images/logo.png',
                height: 200.0,
                width: 200.0,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: "Phone"),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF00E4DF))),
                onPressed: () => _handleLogin(context),
                child: Text("Log In"),
              ),
              const SizedBox(height: 1.0),
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFFA9A9A9)),
                ),
                onPressed: () {
                  // Navigate to signup page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                child: const Text("Don't have an account? Sign up"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
