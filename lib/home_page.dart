import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _peakFlowController = TextEditingController();

  String _selectedGender = 'Male'; // Default gender is male

  // Function to handle analyze button press
  void _handleAnalyze(BuildContext context) async {
    // Get input values
    String name = _nameController.text;
    double height = double.tryParse(_heightController.text) ?? 0.0;
    double weight = double.tryParse(_weightController.text) ?? 0.0;
    int age = int.tryParse(_ageController.text) ?? 0;
    double peakFlow = double.tryParse(_peakFlowController.text) ?? 0.0;

    // Calculate PEF based on gender
    double pef = (_selectedGender == 'Female')
        ? (-1.454 * age + 2.368 * height)
        : (-1.807 * age + 3.206 * height);

    // Calculate correct reading percentage
    double correctReadingPercentage =
        ((pef / peakFlow) * 100); // assuming peakFlow is the actual reading

    // Save data to database (replace this with your database logic)
    await _saveUserData(name, height, weight, age, peakFlow, pef);

    // Navigate to result screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ResultScreen(correctReadingPercentage: correctReadingPercentage),
      ),
    );
  }

  // Function to save user data to local database
  Future<void> _saveUserData(
    String name,
    double height,
    double weight,
    int age,
    double peakFlow,
    double pef,
  ) async {
    // You need to implement your database logic here
    // Open the database, insert or update the user's data
    // Example:
    // Database database = await openDatabase(
    //   join(await getDatabasesPath(), 'user_database.db'),
    //   version: 1,
    // );
    // await database.insert(
    //   'users',
    //   {
    //     'name': name,
    //     'height': height,
    //     'weight': weight,
    //     'age': age,
    //     'peakFlow': peakFlow,
    //     'pef': pef,
    //   },
    //   conflictAlgorithm: ConflictAlgorithm.replace,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextFormField(
              controller: _heightController,
              decoration: InputDecoration(labelText: "Height (cm)"),
              keyboardType: TextInputType.number,
            ),
            DropdownButtonFormField<String>(
              value: _selectedGender,
              onChanged: (String? value) {
                setState(() {
                  _selectedGender = value!;
                });
              },
              items: <String>['Male', 'Female'].map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
              decoration: InputDecoration(labelText: "Gender"),
            ),
            TextFormField(
              controller: _weightController,
              decoration: InputDecoration(labelText: "Weight (kg)"),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _ageController,
              decoration: InputDecoration(labelText: "Age"),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _peakFlowController,
              decoration: InputDecoration(labelText: "Peak Flow Meter Reading"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _handleAnalyze(context), // Pass context here
              child: Text("Analyze"),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final double correctReadingPercentage;

  ResultScreen({required this.correctReadingPercentage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Correct Reading Percentage:\n${correctReadingPercentage.toStringAsFixed(2)}%",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
