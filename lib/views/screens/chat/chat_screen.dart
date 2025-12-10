import 'package:flutter/material.dart';
import 'package:lekra/data/models/message_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/screens/chat/component/bottom_bar.dart';
import 'package:lekra/views/screens/chat/component/meassge_container.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void dispose() {
    messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom({bool animate = true}) {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position.maxScrollExtent;
    if (animate) {
      _scrollController.animateTo(
        position,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    } else {
      _scrollController.jumpTo(position);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const BackButton(color: white),
        elevation: 0,
        backgroundColor: primaryColor,
        titleSpacing: 0,
        title: Row(
          children: [
            const CustomImage(
              path: "",
              isProfile: true,
              height: 40,
              width: 40,
              radius: 50,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Venkatesh",
                  style: Helper(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: white,
                      ),
                ),
                Text(
                  "Online",
                  style: Helper(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: white.withValues(alpha: 0.9)),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
            color: white,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.videocam),
            color: white,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.imagesChatBg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withValues(alpha: 0.03)),
          ),
          Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: ListView.builder(
                    controller: _scrollController,
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      final msg = messagesList[index];
                      return MassageContainer(messageModel: msg);
                    },
                    physics: const BouncingScrollPhysics(),
                  ),
                ),
              ),
              BottomBar(messageController: messageController),
            ],
          ),
        ],
      ),
    );
  }
}
