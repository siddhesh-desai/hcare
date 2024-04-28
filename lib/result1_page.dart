import 'package:flutter/material.dart';
import 'package:hcare/main.dart';
import 'package:hcare/q7_page.dart';

class Result1Page extends StatefulWidget {
  @override
  State<Result1Page> createState() => _Result1PageState();
}

class _Result1PageState extends State<Result1Page> {
  double _calculatePEF() {
    int age = currData.age ?? 0;
    int height = currData.height ?? 0;
    int peakFlow = currData.peakFlowReading ?? 0;
    // print(globalMobileNumber);
    // print(age);
    // print(height);
    // print(peakFlow);

    double pef = (currData.gender == 'Female')
        ? (-1.454 * age + 2.368 * height)
        : (-1.807 * age + 3.206 * height);

    currData.pef = pef;

    double correctReadingPercentage = ((pef / peakFlow) * 100);

    currData.percentage = correctReadingPercentage;

    return correctReadingPercentage;
  }

  void _handleNext(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Question7Page()),
    );
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
                'Correct Reading Percentage is:',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFFA9A9A9)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Text(
                _calculatePEF().toStringAsFixed(2) + " %",
                style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
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
                      child: Text('Do Additional Analysis'),
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
