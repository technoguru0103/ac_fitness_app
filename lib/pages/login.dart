import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top orange logo
            const Padding(
              padding: EdgeInsets.only(top: 80.0),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.orange,
                child: Text(
                  'AC',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Title
            const Text(
              'Sign In To Alone Clone',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 8),

            // Subtitle
            const Text(
              "Let’s personalize your fitness",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            // Email Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  labelText: 'Email Address',
                  hintText: 'aloneclone@aloneclone.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Password Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  labelText: 'Password',
                  hintText: '**********',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: const Icon(Icons.visibility_off),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Sign In Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Add your logic here (e.g., navigate to home page)
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign In',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Social Media Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const FaIcon(FontAwesomeIcons.instagram,
                      color: Colors.grey),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () {},
                  icon: const FaIcon(FontAwesomeIcons.facebook,
                      color: Colors.grey),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () {},
                  icon: const FaIcon(FontAwesomeIcons.linkedin,
                      color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Sign Up and Forgot Password Links
            const Text.rich(
              TextSpan(
                text: "Don't have an account? ",
                style: TextStyle(color: Colors.grey),
                children: [
                  TextSpan(
                    text: "Sign Up.",
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold),
                    // Add navigation to Sign Up page here
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            GestureDetector(
              onTap: () {
                // Add Forgot Password logic here
              },
              child: const Text(
                'Forgot Password',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
