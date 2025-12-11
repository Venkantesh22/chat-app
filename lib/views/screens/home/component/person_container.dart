import 'package:flutter/material.dart';
import 'package:lekra/data/models/user_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';

class PersonContainer extends StatelessWidget {
  final UserModel? user;

  const PersonContainer({
    super.key,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              spreadRadius: 0,
              blurRadius: 6,
              color: black.withValues(alpha: 0.1),
            )
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImage(
            path: user?.image ?? "",
            isProfile: true,
            height: 50,
            width: 50,
            radius: 50,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      user?.name ?? "Unknown",
                      style: Helper(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    // Text(
                    //   !isSearch ? time ?? "" : "",
                    //   style: Helper(context).textTheme.bodySmall?.copyWith(),
                    // )
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  user?.email ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: Helper(context).textTheme.bodySmall?.copyWith(
                        color: greyText,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
