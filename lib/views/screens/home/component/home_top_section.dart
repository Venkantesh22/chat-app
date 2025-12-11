import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/screens/auth_screens/onboarding_screen.dart';

class HomeTopSection extends StatelessWidget {
  const HomeTopSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Hello, ${authController.userModel?.name ?? ""}",
                  style: Helper(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: greyLight),
                ),
              ),
              CustomImage(
                onTap: () async {
                  Get.find<AuthController>().logout().then((value) {
                    if (value) {
                      navigate(
                          context: context,
                          page: OnboardingScreen(),
                          isRemoveUntil: true);
                      showToast(message: "Logout", typeCheck: value);
                    }
                  });
                },
                radius: 50,
                path: authController.userModel?.image ?? "",
                isProfile: true,
                height: 50,
                width: 50,
              )
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Welcome To ${AppConstants.appName}",
            style: Helper(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700, fontSize: 24, color: white),
          ),
        ],
      );
    });
  }
}
