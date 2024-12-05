import 'package:ac_fit/store/app_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
// ignore: depend_on_referenced_packages
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:ac_fit/middlewares/auth_middleware.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  int _errorCode = 0;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? emailValidator(String? value) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (value == null || value.isEmpty) {
      return "Email is required";
    } else if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    } else if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, _ViewModel>(
        converter: (store) => _ViewModel(
            isLoading: store.state.authState.isLoading,
            message: store.state.authState.message,
            // ignore: avoid_types_as_parameter_names
            loginUser: (email, password) =>
                store.dispatch(login(email, password, () {
                  context.go('/data');
                }, (errorCode) {
                  if (errorCode == 403) {
                    context.go('/verify-email');
                  }
                }))),
        builder: (context, vm) {
          return SingleChildScrollView(
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
                  'Sign In to Alone Clone',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 8),

                // Subtitle
                const Text(
                  "Let's personalize your fitness",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 30),

                // Form Fields
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email Field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            labelText: 'Email Address',
                            hintText: 'aloneclone@aloneclone.com',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: emailValidator,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Password Field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            labelText: 'Password',
                            hintText: '**********',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          validator: passwordValidator,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                if (vm.message != null)
                  Text(vm.message!,
                      style: const TextStyle(color: Colors.green)),

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
                    onPressed: vm.isLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              final email = _emailController.text.trim();
                              final password = _passwordController.text.trim();

                              // Debugging logs
                              developer.log("Email entered: $email",
                                  name: "LogIn Debug");
                              developer.log("Password entered: $password",
                                  name: "Signup Debug");
                              vm.loginUser(email, password);
                            }
                          },
                    child: vm.isLoading
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Signing In...',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Sign In',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
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
                RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: const TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        text: "Sign Up.",
                        style: const TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.bold),
                        // Add navigation to Sign Up page here
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.go('/signup');
                          },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                GestureDetector(
                  onTap: () {
                    // Add Forgot Password logic here
                    context.go('/reset-password');
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
          );
        },
      ),
    );
  }
}

class _ViewModel {
  final bool isLoading;
  final String? message;
  final Function(String, String) loginUser;

  _ViewModel({
    required this.isLoading,
    required this.message,
    required this.loginUser,
  });
}
