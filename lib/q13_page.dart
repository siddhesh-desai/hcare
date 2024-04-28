import 'package:flutter/material.dart';
import 'package:hcare/main.dart';
import 'package:hcare/q4_page.dart';
import 'package:hcare/q8_page.dart';
import 'package:hcare/result2_page.dart';

class Question13Page extends StatefulWidget {
  @override
  State<Question13Page> createState() => _Question13PageState();
}

class _Question13PageState extends State<Question13Page> {
  String _selectedPeriods = "Yes";

  void _handleNext(BuildContext context) async {
    // Get input values
    if (_selectedPeriods == "Yes") {
      currData.intermittentPeriods = true;
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Result2Page(
                ans: "Likely to have asthma, unlikely to have COPD")),
      );
    } else {
      currData.intermittentPeriods = false;
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Result2Page(
                ans: "Likely to have COPD, unlikely to have asthma")),
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
                'Question 13',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFFA9A9A9)),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 40),
              Text(
                'Do you have intermittent asymptomatic periods lasting for >7 days',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              DropdownButtonFormField<String>(
                value: _selectedPeriods,
                onChanged: (String? value) {
                  setState(() {
                    _selectedPeriods = value!;
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
