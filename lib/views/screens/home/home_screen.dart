import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/controllers/home_controller.dart';
import 'package:lekra/data/models/user_model.dart';
import 'package:lekra/firebase/firebase_database/massage_database.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/chat/chat_screen.dart';
import 'package:lekra/views/screens/home/component/home_top_section.dart';
import 'package:lekra/views/screens/home/component/person_container.dart';
import 'package:lekra/views/widget/text_box/app_text_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isLoading = true;
      });
      final authController = Get.find<AuthController>();
      User? currentUser = FirebaseAuth.instance.currentUser;

      authController.fetchProfile(currentUser?.uid ?? "");
      getAllUserData();
      setState(() {
        isLoading = false;
      });
    });
  }

  Stream? chatRoomStream;
  bool isLoading = false;
  getAllUserData() async {
    log("---------- getAndSendMessage --------------");
    chatRoomStream = await MassageDatabase().getAllUser();
  }

  Widget chatRoomList() {
    return GetBuilder<HomeController>(builder: (homeController) {
      return StreamBuilder(
        stream: chatRoomStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.separated(
                  padding: EdgeInsets.zero,
                  separatorBuilder: (_, __) => const SizedBox(height: 6),
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    UserModel user =
                        UserModel.fromJson(ds.data() as Map<String, dynamic>);
                    return GestureDetector(
                      onTap: () async {
                        var chatRoomId = await homeController.createChatRoom(
                            Get.find<AuthController>().userModel?.name ?? "",
                            user.name ?? "");

                        Map<String, dynamic> chatInfoMap = {
                          'users': [
                            Get.find<AuthController>().userModel?.name ?? "",
                            user.name ?? ""
                          ],
                        };

                        await MassageDatabase()
                            .createChatRoom(chatRoomId, chatInfoMap)
                            .then((value) {
                          if (value) {
                            homeController.setSelectPersonForChat(value: user);
                            navigate(context: context, page: ChatScreen());
                          }
                        });
                      },
                      child: PersonContainer(
                        user: user,
                      ),
                    );
                  },
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                )
              : Container();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: GetBuilder<AuthController>(builder: (authController) {
        return authController.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GetBuilder<HomeController>(
                builder: (homeController) {
                  if (isLoading) {
                    Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: HomeTopSection(),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: const BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              )),
                          child: Column(
                            children: [
                              AppTextFieldWithHeading(
                                controller: homeController.searchController,
                                bgColor: greyLight,
                                hindText: "Search a person",
                                onChanged: (query) {
                                  homeController.searchUser(query);
                                },
                                preFixWidget: const Icon(
                                  Icons.person_2_outlined,
                                  color: primaryColor,
                                ),
                              ),
                              homeController.searchController.text.isNotEmpty
                                  ? Expanded(
                                      child: Obx(() {
                                        if (homeController.isSearching.value) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }

                                        if (homeController.searchList.isEmpty) {
                                          return Center(
                                            child: Text(
                                              homeController.searchController
                                                      .text.isEmpty
                                                  ? "Search for a person"
                                                  : "No users found",
                                              style: Helper(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(color: greyText),
                                            ),
                                          );
                                        }

                                        return ListView.separated(
                                          itemBuilder: (context, index) {
                                            final user = homeController
                                                .searchList[index];
                                            return GestureDetector(
                                              onTap: () async {
                                                var chatRoomId = await homeController
                                                    .createChatRoom(
                                                        Get.find<AuthController>()
                                                                .userModel
                                                                ?.name ??
                                                            "",
                                                        user.name ?? "");

                                                Map<String, dynamic>
                                                    chatInfoMap = {
                                                  'users': [
                                                    Get.find<AuthController>()
                                                            .userModel
                                                            ?.name ??
                                                        "",
                                                    user.name ?? ""
                                                  ],
                                                };

                                                await MassageDatabase()
                                                    .createChatRoom(
                                                        chatRoomId, chatInfoMap)
                                                    .then((value) {
                                                  if (value) {
                                                    homeController
                                                        .setSelectPersonForChat(
                                                            value: user);
                                                    navigate(
                                                        context: context,
                                                        page: ChatScreen());
                                                  }
                                                });
                                              },
                                              child: PersonContainer(
                                                user: user,
                                              ),
                                            );
                                          },
                                          separatorBuilder: (_, __) =>
                                              const SizedBox(height: 6),
                                          itemCount:
                                              homeController.searchList.length,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                        );
                                      }),
                                    )
                                  : Expanded(child: chatRoomList()),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
      }),
    );
  }
}
