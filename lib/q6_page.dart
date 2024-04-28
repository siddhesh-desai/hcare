import 'package:flutter/material.dart';
import 'package:hcare/main.dart';
import 'package:hcare/result1_page.dart';

class Question6Page extends StatefulWidget {
  @override
  State<Question6Page> createState() => _Question6PageState();
}

class _Question6PageState extends State<Question6Page> {
  final TextEditingController _peakFlowController = TextEditingController();

  void _handleNext(BuildContext context) async {
    // Get input values
    String peakFlow = _peakFlowController.text;

    // Validate input fields
    if (peakFlow.isEmpty) {
      _showErrorDialog(context, "Please fill in your peak flow meter reading!");
      return;
    } else {
      currData.peakFlowReading = int.parse(peakFlow);
      // Navigate to the next question page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Result1Page()),
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
                'Question 6',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFFA9A9A9)),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 40),
              Text(
                'What is your Peak Flow Meter Reading?',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _peakFlowController,
                decoration: InputDecoration(
                  hintText: 'Enter your peak flow',
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
                      child: Text('Calculate PEF'),
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
