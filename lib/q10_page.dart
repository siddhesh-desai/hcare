import 'package:flutter/material.dart';
import 'package:hcare/main.dart';
import 'package:hcare/q11_page.dart';
import 'package:hcare/q4_page.dart';
import 'package:hcare/q8_page.dart';
import 'package:hcare/result2_page.dart';

class Question10Page extends StatefulWidget {
  @override
  State<Question10Page> createState() => _Question10PageState();
}

class _Question10PageState extends State<Question10Page> {
  String _selectedOnsetAge = ">=40 years";

  void _handleNext(BuildContext context) async {
    // Get input values
    if (_selectedOnsetAge == ">=40 years") {
      currData.ageSymptoms = true;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Question11Page()),
      );
    } else {
      currData.ageSymptoms = false;
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Result2Page(
                ans: "Likely to have asthma, unlikely to have COPD")),
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
                'Question 10',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFFA9A9A9)),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 40),
              Text(
                'Age of onset of symptoms',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              DropdownButtonFormField<String>(
                value: _selectedOnsetAge,
                onChanged: (String? value) {
                  setState(() {
                    _selectedOnsetAge = value!;
                  });
                },
                items: <String>['>=40 years', '<40 years']
                    .map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
                decoration: InputDecoration(labelText: "Consider earliest age"),
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
