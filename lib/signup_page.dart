import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hcare/home_screen.dart';
import 'package:hcare/login_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Function to handle sign up button press
  void _handleSignUp(BuildContext context) async {
    // Get input values
    String name = _nameController.text;
    String phone = _phoneController.text;
    String password = _passwordController.text;

    // Validate input fields (You can add more validation)
    if (name.isEmpty || phone.isEmpty || password.isEmpty) {
      _showErrorDialog(context, "Please fill in all fields.");
      return;
    }

    // Save user data to local database
    await _saveUserData(name, phone, password);

    // Navigate to home screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  // Function to save user data to local database
  Future<void> _saveUserData(String name, String phone, String password) async {
    // Open the database
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'user_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, phone TEXT, password TEXT)",
        );
      },
      version: 1,
    );

    // Insert user data into the database
    await database.insert(
      'users',
      {'name': name, 'phone': phone, 'password': password},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Function to show error dialog
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
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
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Phone"),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _handleSignUp(context), // Pass context here
              child: Text("Sign Up"),
            ),
            SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                // Navigate to login page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text("Already have an account? Log in"),
            ),
          ],
        ),
      ),
    );
  }
}
