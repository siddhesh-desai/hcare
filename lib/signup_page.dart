import 'package:flutter/material.dart';
import 'package:hcare/main.dart';
import 'package:hcare/q1_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hcare/login_page.dart';

//Creating a stateful widget
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //Input Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Function to handle sign up button press
  void _handleSignUp(BuildContext context) async {
    String name = _nameController.text;
    String phone = _phoneController.text;
    String password = _passwordController.text;

    // Validate input fields
    if (name.isEmpty || phone.isEmpty || password.isEmpty) {
      _showErrorDialog(context, "Please fill in all fields.");
      return;
    } else if (phone.length != 10) {
      _showErrorDialog(context, "Please enter a valid mobile number");
      return;
    }

    // Save user data to local database
    bool savedSuccessfully =
        await _saveUserData(name, phone, password, context);

    // If data saved successfully, navigate to home screen
    if (savedSuccessfully) {
      globalMobileNumber = phone;
      currData.phone = phone;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Question1Page()),
      );
    } else {
      _showErrorDialog(context, "Something went wrong.");
    }
  }

  Future<bool> _saveUserData(
      String name, String phone, String password, BuildContext context) async {
    // Open the database
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'user_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(phone TEXT PRIMARY KEY, name TEXT, password TEXT)",
        );
      },
      version: 1,
    );

    // Check if phone number already exists
    List<Map<String, dynamic>> result = await database.query(
      'users',
      where: 'phone = ?',
      whereArgs: [phone],
    );

    if (result.isNotEmpty) {
      // Phone number already exists, show a toast
      _showErrorDialog(context, "Phone number already exists!");
      return false; // Data not saved successfully
    } else {
      // Insert user data into the database
      await database.insert(
        'users',
        {'name': name, 'phone': phone, 'password': password},
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
      return true; // Data saved successfully
    }
  }

  // Function to show error dialog
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
                controller: _nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              SizedBox(height: 10.0),
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
                onPressed: () => _handleSignUp(context),
                child: Text("Sign Up"),
              ),
              const SizedBox(height: 1.0),
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFFA9A9A9)),
                ),
                onPressed: () {
                  // Navigate to login page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: const Text("Already have an account? Log in"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
