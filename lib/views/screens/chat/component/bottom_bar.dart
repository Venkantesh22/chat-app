import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/meassage_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';

class BottomBar extends StatefulWidget {
  final TextEditingController messageController;
  const BottomBar({super.key, required this.messageController});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MassageController>(builder: (massageController) {
      return AnimatedPadding(
        duration: const Duration(milliseconds: 160),
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SafeArea(
          top: false,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                )
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    // TODO: open emoji picker
                  },
                  icon: const Icon(Icons.emoji_emotions_outlined),
                  color: primaryColor,
                ),
                IconButton(
                  onPressed: () {
                    // TODO: attachment picker
                  },
                  icon: const Icon(Icons.attach_file),
                  color: primaryColor,
                ),
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: greyLight,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: widget.messageController,
                            textInputAction: TextInputAction.send,
                            minLines: 1,
                            maxLines: 5,
                            onSubmitted: (_) {},
                            decoration: InputDecoration(
                              isCollapsed: true,
                              border: InputBorder.none,
                              hintText: 'Type a message',
                              hintStyle: Helper(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: greyText),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.send,
                              color: primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
