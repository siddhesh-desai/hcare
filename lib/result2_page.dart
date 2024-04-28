import 'package:flutter/material.dart';
import 'package:hcare/main.dart';
import 'package:hcare/q1_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Result2Page extends StatefulWidget {
  final String ans;
  Result2Page({Key? key, required this.ans});

  @override
  State<Result2Page> createState() => _Result2PageState();
}

class _Result2PageState extends State<Result2Page> {
  String? _ans;

  @override
  void initState() {
    super.initState();
    _ans = widget.ans;
    insertUserData();
  }

  void _handleNext(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Question1Page()),
    );
  }

  // Function to insert data into the database
  Future<void> insertUserData() async {
    // Open the database
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'user_inputs.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users("
          "phone TEXT PRIMARY KEY, "
          "name TEXT, "
          "height INTEGER, "
          "gender TEXT, "
          "weight INTEGER, "
          "age INTEGER, "
          "peakFlowReading INTEGER, "
          "pef REAL, "
          "percentage REAL, "
          "breathlessness INTEGER, "
          "beyond6Months INTEGER, "
          "haveCough INTEGER, "
          "ageSymptoms INTEGER, "
          "smokingBeyond10 INTEGER, "
          "biomassSmoke INTEGER, "
          "intermittentPeriods INTEGER"
          ")",
        );
      },
      version: 1,
    );

    // Insert data into the database
    await database.insert(
      'users',
      {
        'phone': currData.phone,
        'name': currData.name,
        'height': currData.height,
        'gender': currData.gender,
        'weight': currData.weight,
        'age': currData.age,
        'peakFlowReading': currData.peakFlowReading,
        'pef': currData.pef,
        'percentage': currData.percentage,
        'breathlessness':
            currData.breathlessness! ? 1 : 0, // Convert boolean to integer
        'beyond6Months': currData.beyond6Months! ? 1 : 0,
        'haveCough': currData.haveCough! ? 1 : 0,
        'ageSymptoms': currData.ageSymptoms! ? 1 : 0,
        'smokingBeyond10': currData.smokingBeyond10! ? 1 : 0,
        'biomassSmoke': currData.biomassSmoke! ? 1 : 0,
        'intermittentPeriods': currData.intermittentPeriods! ? 1 : 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
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
                'Correct Reading Percentage is: ' +
                    currData.percentage!.toStringAsFixed(2) +
                    " %",
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFFA9A9A9)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Text(
                _ans ?? "",
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF00E4DF))),
                      onPressed: () => _handleNext(context),
                      child: Text('Refill Data'),
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
