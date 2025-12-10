import 'package:flutter/material.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/common_button.dart';
import 'package:lekra/views/base/custom_image.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          const CustomImage(
            path: Assets.imagesLogin,
          ),
          Padding(
            padding: AppConstants.screenPadding,
            child: Column(
              children: [
                Text(
                  "Enjoy the new experience with ConnectAssure",
                  textAlign: TextAlign.center,
                  style: Helper(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700, fontSize: 24),
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomButton(
                  color: primaryColor,
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomImage(
                        path: Assets.imagesSearch,
                        height: 24,
                        width: 24,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        "Single in with Google",
                        style: Helper(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: white),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
