import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/assets.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    // Simulate some initialization delay
    await Future.delayed(const Duration(seconds: 3));
    // Navigate to the home screen
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Optional: Prevents back navigation from the splash screen
      body: Container(
        color: Colors.white, // Set your preferred background color
        child: Center(
          child: Image.asset(
            Assets.images.splashLogo, // Ensure the image exists
            width: 200,
          ),
        ),
      ),
    );
  }
}
