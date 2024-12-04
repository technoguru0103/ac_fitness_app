import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HealthAssessmentPage extends StatefulWidget {
  @override
  _HealthAssessmentPageState createState() => _HealthAssessmentPageState();
}

class _HealthAssessmentPageState extends State<HealthAssessmentPage> {
  String? selectedCondition;

  final List<Map<String, dynamic>> healthConditions = [
    {"label": "Diabetics", "icon": FontAwesomeIcons.syringe},
    {"label": "High cholesterol", "icon": FontAwesomeIcons.heartbeat},
    {"label": "Joint Issues", "icon": FontAwesomeIcons.bone},
    {"label": "Mobility Issues", "icon": FontAwesomeIcons.wheelchair},
    {"label": "None! 👍", "icon": FontAwesomeIcons.thumbsUp},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assessment'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Do you have any health conditions?',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: healthConditions.length,
                itemBuilder: (context, index) {
                  final condition = healthConditions[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCondition = condition['label'];
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        color: selectedCondition == condition['label']
                            ? Colors.orange
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: FaIcon(
                          condition['icon'],
                          color: selectedCondition == condition['label']
                              ? Colors.white
                              : Colors.black,
                        ),
                        title: Text(
                          condition['label'],
                          style: TextStyle(
                            color: selectedCondition == condition['label']
                                ? Colors.white
                                : Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: selectedCondition != null
                  ? () {
                      // Handle the continue button logic here
                      print('Selected condition: $selectedCondition');
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Center(
                child: Text(
                  'Continue',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
