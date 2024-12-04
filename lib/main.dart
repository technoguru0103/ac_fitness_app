import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/google_signup_screen.dart';
import 'screens/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get device height and width for responsiveness
    final size = MediaQuery.of(context).size;
    final double screenHeight = size.height;
    final double screenWidth = size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/welcome.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content in the center
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.08, // Responsive horizontal padding
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  Image.asset(
                    "assets/images/logo.png", // Replace with your logo path
                    height: screenHeight *
                        0.1, // Responsive height (10% of screen height)
                  ),
                  SizedBox(
                      height:
                          screenHeight * 0.03), // Responsive vertical spacing

                  // Welcome Text
                  Text(
                    "Welcome To AC Fit",
                    style: TextStyle(
                      fontSize: screenHeight * 0.035, // Responsive font size
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.015),

                  // Subtitle
                  Text(
                    "Your REAL Fitness Partner",
                    style: TextStyle(
                      fontSize: screenHeight * 0.02,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // Get Started Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.2, // Button width
                        vertical: screenHeight * 0.02, // Button height
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      // Navigate to the next screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Get Started",
                          style: TextStyle(
                            fontSize: screenHeight * 0.022,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        const Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Sign In Text
                  GestureDetector(
                    onTap: () {
                      // Navigate to Sign In Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LogInScreen()),
                      );
                    },
                    child: Text(
                      "Already have an account? Sign In",
                      style: TextStyle(
                        fontSize: screenHeight * 0.018,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
