import 'dart:async';

import 'package:coresight/shared/theme.dart';
import 'package:coresight/utils/status_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Your side effect here
    _checkOnboardingStatus();
    setStatusBar(
      color: Colors.transparent,
      iconBrightness: Brightness.light,
      barBrightness: Brightness.dark,
    );
  }

  Future<void> _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final onboardingComplete = prefs.getBool('onboarding_complete') ?? false;

    await Future.delayed(Duration(seconds: 1)); // optional splash delay

    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      onboardingComplete ? '/home' : '/onboarding',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/Logo.png', width: 250),
            SizedBox(height: 4),
            Text(
              'Clear Insights Confident Moves',
              style: whiteTextStyle.copyWith(fontSize: h6),
            ),
          ],
        ),
      ),
    );
  }
}
