import 'package:ac_fit/main.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class HealthAssessmentPage extends StatefulWidget {
  const HealthAssessmentPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
        title: const Text('Assessment'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Do you have any health conditions?',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
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
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: const Center(
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
