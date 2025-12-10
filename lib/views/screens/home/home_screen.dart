import 'package:flutter/material.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Hello, Venkatesh",
              style: Helper(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700, fontSize: 24, color: white),
            )
          ],
        ),
      ),
    );
  }
}
