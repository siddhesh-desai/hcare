import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hcare/home_screen.dart';

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
      _showErrorSnackBar(context, "Please fill in all fields.");
      return;
    }

    // Check credentials in the database
    bool isAuthenticated = await _checkCredentials(phone, password);

    if (isAuthenticated) {
      // Navigate to home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      _showErrorSnackBar(context, "Wrong phone number or password.");
    }
  }

  // Function to check credentials in the database
  Future<bool> _checkCredentials(String phone, String password) async {
    // Open the database
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'user_databasnoe.db'),
    );

    // Query the database for user with matching phone and password
    List<Map<String, dynamic>> result = await database.query(
      'users',
      where: 'phone = ? AND password = ?',
      whereArgs: [phone, password],
    );

    // Check if user exists with provided credentials
    return result.isNotEmpty;
  }

  // Function to show error SnackBar
  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
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
              onPressed: () => _handleLogin(context), // Pass context here
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
