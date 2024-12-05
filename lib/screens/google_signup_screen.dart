import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GoogleSignUpScreen extends StatefulWidget {
  const GoogleSignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GoogleSignUpScreenState createState() => _GoogleSignUpScreenState();
}

class _GoogleSignUpScreenState extends State<GoogleSignUpScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId:
          "699810800486-79icflkd60hgatvbdu2f8fa6grf79nh3.apps.googleusercontent.com",
      scopes: ['email']);

  // Function to handle Google sign-in
  Future<void> _handleGoogleSignUp() async {
    try {
      final GoogleSignInAccount? user = await _googleSignIn.signIn();

      if (user != null) {
        // Get Google sign-in details (ID token)
        final GoogleSignInAuthentication googleAuth = await user.authentication;
        final String tokenId = googleAuth.idToken!;

        // Send the tokenId to your backend server for verification and user creation
        const url = 'http://localhost:5000/api/auth/google'; // Your backend URL

        final response = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'tokenId': tokenId}),
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          final String token = responseData['token'];

          // Save token locally (using shared_preferences)
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('jwt_token', token);

          // Navigate to the next screen (dashboard or profile screen)
          print('Google login successful! Token: $token');
          // Navigate to another screen or dashboard
        } else {
          print('Google sign-in failed: ${response.body}');
        }
      }
    } catch (error) {
      print('Error during Google sign-in: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Sign-Up')),
      body: Center(
        child: ElevatedButton(
          onPressed: _handleGoogleSignUp,
          child: const Text('Sign up with Google'),
        ),
      ),
    );
  }
}
