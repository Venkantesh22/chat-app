import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/controllers/home_controller.dart';
import 'package:lekra/data/models/user_model.dart';
import 'package:lekra/firebase/firebase_database/massage_database.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/date_formatters_and_converters.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/screens/chat/component/bottom_bar.dart';
import 'package:lekra/views/screens/chat/component/meassge_container.dart';
import 'package:random_string/random_string.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? chatRoomId;
  String? messageId;

  Stream? messageStream;
  UserModel? user;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        isLoading = true;
      });
      final homeController = Get.find<HomeController>();
      user = Get.find<AuthController>().userModel;
      chatRoomId = await homeController.createChatRoom(
          homeController.selectPersonForChat?.name ?? "",
          Get.find<AuthController>().userModel?.name ?? "");
      getAndSendMessage();
      _scrollToBottom();
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void getAndSendMessage() async {
    log("---------- getAndSendMessage --------------");
    messageStream = await MassageDatabase().getChatRoomMessage(chatRoomId);
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

  addMessage(bool sendClicked) async {
    if (messageController.text.trim().isNotEmpty && chatRoomId != null) {
      String message = messageController.text.trim();
      UserModel userModel = Get.find<AuthController>().userModel ?? UserModel();
      messageController.clear();
      Map<String, dynamic> messageInforMap = {
        'message': message,
        'sendBy': userModel.name,
        'ts': DateFormatters().hMA.format(getDateTime()),
        'time': FieldValue.serverTimestamp(),
        'imgUrl': userModel.image
      };

      messageId = randomAlphaNumeric(10);
      await MassageDatabase()
          .addMessage(chatRoomId!, messageId!, messageInforMap)
          .then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          'lastMessage': message,
          'lastMessageSendBy': userModel.name,
          'lastMessageSendTs': DateFormatters().hMA.format(getDateTime()),
          'time': FieldValue.serverTimestamp(),
        };
        MassageDatabase()
            .updateLastMessageSend(chatRoomId!, lastMessageInfoMap);

        if (sendClicked) {
          messageController.text = "";
        }
      });
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
        title: GetBuilder<HomeController>(builder: (homeController) {
          return Row(
            children: [
              CustomImage(
                path: homeController.selectPersonForChat?.image ?? "",
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
                    homeController.selectPersonForChat?.name ?? "",
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
          );
        }),
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
                    child: StreamBuilder(
                        stream: messageStream,
                        builder: (context, AsyncSnapshot snapshot) {
                          if (isLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return snapshot.hasData
                              ? ListView.builder(
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot ds =
                                        snapshot.data.docs[index];
                                    return MassageContainer(
                                        message: ds['message'],
                                        time: ds['ts'],
                                        sendByMe: user?.name == ds['sendBy']);
                                  },
                                  reverse: true,
                                  itemCount: snapshot.data.docs.length,
                                )
                              : Container();
                        })),
              ),
              BottomBar(
                  messageController: messageController,
                  onSend: () => addMessage(true)),
            ],
          ),
        ],
      ),
    );
  }
}
