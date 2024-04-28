import 'package:flutter/material.dart';
import 'package:hcare/main.dart';
import 'package:hcare/q3_page.dart';
import 'package:hcare/q5_page.dart';

class Question4Page extends StatefulWidget {
  @override
  State<Question4Page> createState() => _Question4PageState();
}

class _Question4PageState extends State<Question4Page> {
  final TextEditingController _weightController = TextEditingController();

  void _handleNext(BuildContext context) async {
    // Get input values
    String weight = _weightController.text;

    // Validate input fields
    if (weight.isEmpty) {
      _showErrorDialog(context, "Please fill in your weight!");
      return;
    } else {
      currData.weight = int.parse(weight);
      // Navigate to the next question page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Question5Page()),
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
                'Question 4',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFFA9A9A9)),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 40),
              Text(
                'What is your weight?',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _weightController,
                decoration: InputDecoration(
                  hintText: 'Enter your weight in kg',
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
