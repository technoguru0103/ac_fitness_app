import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:go_router/go_router.dart';

import 'package:ac_fit/store/app_store.dart';
import 'package:ac_fit/screens/login_screen.dart';
// import 'package:ac_fit/screens/google_signup_screen.dart';
import 'package:ac_fit/screens/signup_screen.dart';
import 'package:ac_fit/screens/welcome_screen.dart';
import 'package:ac_fit/screens/reset_password_screen.dart';
import 'package:ac_fit/screens/data_screen.dart';
import 'package:ac_fit/screens/assessment_screen.dart';
import 'package:ac_fit/screens/verify_email_screen.dart';

void main() {
  runApp(ACFitnessApp());
}

class ACFitnessApp extends StatelessWidget {
  ACFitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp.router(
          routerConfig: _routerConifg,
        ));
  }

  final _routerConifg = GoRouter(routes: [
    GoRoute(path: '/', builder: (context, state) => const WelcomeScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LogInScreen()),
    GoRoute(path: '/signup', builder: (context, state) => const SignUpScreen()),
    GoRoute(
        path: '/reset-password',
        builder: (context, state) => const ResetPasswordScreen()),
    GoRoute(
        path: '/verify-email',
        builder: (context, state) => const VerifyEmailScreen()),
    GoRoute(
        path: '/assessment',
        builder: (context, state) => const HealthAssessmentPage()),
    GoRoute(
      path: '/data',
      builder: (context, state) => const DataScreen(),
      redirect: (context, state) {
        final isAuthenticated = store.state.authState.isAuthenticated;
        return isAuthenticated ? null : '/login';
      },
    ),
  ]);
}
