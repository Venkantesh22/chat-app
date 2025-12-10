import 'package:flutter/material.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/date_formatters_and_converters.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer({
    super.key,
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
              offset: Offset(0, 4),
              spreadRadius: 0,
              blurRadius: 6,
              color: black.withValues(alpha: 0.1),
            )
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomImage(
            path: "",
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
                      "Venkatesh",
                      style: Helper(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    Text(
                      DateFormatters().hMA.format(DateTime.now()),
                      style: Helper(context).textTheme.bodySmall?.copyWith(),
                    )
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "Venkatesh jlksdkjlkjfsldjf sldjl sdjfksjdlfj sdlflsdkf sddsjfsdjflsdjflsdkfslkdjflsdkjflsdkjfsl dlsdflj ",
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
