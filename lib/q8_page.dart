import 'package:flutter/material.dart';
import 'package:hcare/main.dart';
import 'package:hcare/q4_page.dart';
import 'package:hcare/q9_page.dart';
import 'package:hcare/result2_page.dart';

class Question8Page extends StatefulWidget {
  @override
  State<Question8Page> createState() => _Question8PageState();
}

class _Question8PageState extends State<Question8Page> {
  String _selectedHowLong = "6 months or more";

  void _handleNext(BuildContext context) async {
    // Get input values
    if (_selectedHowLong == "6 months or more") {
      currData.beyond6Months = true;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Question9Page()),
      );
    } else {
      currData.beyond6Months = false;
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Result2Page(ans: "Unlikely to have asthma or COPD")),
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
                'Question 8',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFFA9A9A9)),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 40),
              Text(
                'For how long?',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              DropdownButtonFormField<String>(
                value: _selectedHowLong,
                onChanged: (String? value) {
                  setState(() {
                    _selectedHowLong = value!;
                  });
                },
                items: <String>['6 months or more', 'Less than 6 months']
                    .map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
                decoration: InputDecoration(labelText: ""),
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
