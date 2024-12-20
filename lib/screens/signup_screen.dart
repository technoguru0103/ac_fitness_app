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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _passwordsMatch = true;
  String _errorMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
            signupUser: (email, password) =>
                store.dispatch(signup(email, password, () {
                  context.go('/verify-email');
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
                  'Sign Up Now!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 8),

                // Subtitle
                const Text(
                  "Make your account under 1 minute",
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
                      const SizedBox(height: 20),

                      // Confirm Password Field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: !_isConfirmPasswordVisible,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            labelText: 'Confirm Password',
                            hintText: '**********',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isConfirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isConfirmPasswordVisible =
                                      !_isConfirmPasswordVisible;
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
                const SizedBox(height: 20),
                if (!_passwordsMatch)
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          border: Border.all(color: Colors.red.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.error, color: Colors.red.shade300),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _errorMessage,
                                style: TextStyle(color: Colors.red.shade800),
                              ),
                            ),
                          ],
                        ),
                      )),
                const SizedBox(height: 30),

                if (vm.message != null)
                  Text(vm.message!,
                      style: const TextStyle(color: Colors.green)),

                // Sign Up Button
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
                              final confirmPassword =
                                  _confirmPasswordController.text.trim();

                              // Debugging logs
                              developer.log("Email entered: $email",
                                  name: "Signup Debug");
                              developer.log("Password entered: $password",
                                  name: "Signup Debug");
                              developer.log(
                                  "Confirm Password entered: $confirmPassword",
                                  name: "Signup Debug");

                              if (password != confirmPassword) {
                                setState(() {
                                  _passwordsMatch = false;
                                  _errorMessage =
                                      "ERROR: Password Don't Match!";
                                });
                                return;
                              } else {
                                setState(() {
                                  _passwordsMatch = true;
                                  _errorMessage = '';
                                });
                                vm.signupUser(email, password);
                              }
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
                                'Signing Up...',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Sign Up',
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

                // Sign In Link
                RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: const TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        text: "Sign In",
                        style: const TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.go('/login');
                          },
                      ),
                    ],
                  ),
                ),
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
  final Function(String, String) signupUser;

  _ViewModel({
    required this.isLoading,
    required this.message,
    required this.signupUser,
  });
}
