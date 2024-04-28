import 'package:flutter/material.dart';
import 'package:hcare/main.dart';
import 'package:hcare/q10_page.dart';
import 'package:hcare/q4_page.dart';
import 'package:hcare/q8_page.dart';
import 'package:hcare/result2_page.dart';

class Question9Page extends StatefulWidget {
  @override
  State<Question9Page> createState() => _Question9PageState();
}

class _Question9PageState extends State<Question9Page> {
  String _selectedCough = "Yes";

  void _handleNext(BuildContext context) async {
    // Get input values
    if (_selectedCough == "Yes") {
      currData.haveCough = true;
    } else {
      currData.haveCough = false;
    }

    if (currData.percentage! >= 80) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Result2Page(ans: "No clinically relevant asthma or COPD")),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Question10Page()),
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
                'Question 9',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFFA9A9A9)),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 40),
              Text(
                'Do you have Cough?',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              DropdownButtonFormField<String>(
                value: _selectedCough,
                onChanged: (String? value) {
                  setState(() {
                    _selectedCough = value!;
                  });
                },
                items: <String>['Yes', 'No'].map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
                decoration: InputDecoration(labelText: "Yes/No"),
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
