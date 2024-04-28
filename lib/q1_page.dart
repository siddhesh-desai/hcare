import 'package:flutter/material.dart';
import 'package:hcare/main.dart';
import 'package:hcare/q2_page.dart';

class Question1Page extends StatefulWidget {
  @override
  State<Question1Page> createState() => _Question1PageState();
}

class _Question1PageState extends State<Question1Page> {
  final TextEditingController _nameController = TextEditingController();

  void _handleNext(BuildContext context) async {
    // Get input values
    String name = _nameController.text;

    // Validate input fields
    if (name.isEmpty) {
      _showErrorDialog(context, "Please fill in your name!");
      return;
    } else {
      currData.name = name;
      // Navigate to the next question page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Question2Page()),
      );
    }
  }

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Question 1',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFFA9A9A9)),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 40),
              Text(
                'What is your name?',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF00E4DF))),
                      onPressed: () => _handleNext(context),
                      child: Text('Next'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
