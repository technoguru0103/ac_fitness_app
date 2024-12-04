import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Subtitle
              const SizedBox(height: 10),
              const Text(
                'Reset Password',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Select what method you’d like to reset.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),
              // Reset Options
              _buildResetOption(
                icon: FontAwesomeIcons.envelope,
                title: 'Send via Email',
                description:
                    'Seamlessly reset your password via email address.',
                color: Colors.orange,
              ),
              const SizedBox(height: 10),
              _buildResetOption(
                icon: FontAwesomeIcons.lock,
                title: 'Send via 2FA',
                description: 'Seamlessly reset your password via 2 Factors.',
                color: Colors.blue,
              ),
              const SizedBox(height: 10),
              _buildResetOption(
                icon: FontAwesomeIcons.google,
                title: 'Send via Google Auth',
                description: 'Seamlessly reset your password via gAuth.',
                color: Colors.purple,
              ),
              const SizedBox(height: 30),
              // Reset Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  // Handle Reset Password action
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Reset Password',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Background Image or Lock Icon
              Center(
                child: Image.asset(
                  'assets/images/lock.png', // Replace with your asset
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResetOption({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[100],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: FaIcon(icon, color: Colors.white),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          description,
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.orange),
        onTap: () {
          // Handle onTap for each method
        },
      ),
    );
  }
}
