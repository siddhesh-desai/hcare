import 'package:flutter/material.dart';
import 'package:hcare/home_page.dart';
import 'package:hcare/main.dart';
import 'package:hcare/q3_page.dart';

class Question2Page extends StatefulWidget {
  @override
  State<Question2Page> createState() => _Question2PageState();
}

class _Question2PageState extends State<Question2Page> {
  final TextEditingController _heightController = TextEditingController();

  void _handleNext(BuildContext context) async {
    // Get input values
    String height = _heightController.text;

    // Validate input fields
    if (height.isEmpty) {
      _showErrorDialog(context, "Please fill in your height!");
      return;
    } else {
      currData?.height = int.parse(height);
      // Navigate to the next question page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Question3Page()),
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
                'Question 2',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFFA9A9A9)),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 40),
              Text(
                'What is your height?',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _heightController,
                decoration: InputDecoration(
                  hintText: 'Enter your height in cm',
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
              const SizedBox(height: 1.0),
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFFA9A9A9)),
                ),
                onPressed: () {
                  // Navigate to signup page
                  Navigator.pop(context);
                },
                child: const Text("<< Go Back"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
