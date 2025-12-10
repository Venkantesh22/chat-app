import 'package:flutter/material.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';

class HomeTopSection extends StatelessWidget {
  const HomeTopSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Hello, Venkatesh",
                style: Helper(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: greyLight),
              ),
            ),
            const CustomImage(
              radius: 20,
              path: "",
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
  }
}
