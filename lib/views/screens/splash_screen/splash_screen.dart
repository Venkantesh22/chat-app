import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:flutter/material.dart';
import 'package:lekra/views/screens/auth_screens/onboarding_screen.dart';
import 'package:lekra/views/screens/home/home_screen.dart';
import '../../../services/constants.dart';
import '../../base/custom_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  Future<void> checkAuth() async {
    await Future.delayed(const Duration(seconds: 2));

    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      if (mounted) {
        navigate(
            context: context, page: const HomeScreen(), isRemoveUntil: true);
      }
    } else {
      if (mounted) {
        navigate(
            context: context,
            page: const OnboardingScreen(),
            isRemoveUntil: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            CustomImage(
              path: Assets.imagesLogo,
              height: size.height * .3,
              width: size.height * .3,
            ),
            const Spacer(flex: 3),
            Text(
              AppConstants.appName,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 26.0,
                  ),
            ),
            Text(
              "Subtitle",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
