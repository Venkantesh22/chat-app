import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/controllers/home_controller.dart';
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
      final authController = Get.find<AuthController>();
      User? currentUser = FirebaseAuth.instance.currentUser;

      authController.fetchProfile(currentUser?.uid ?? "");
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
                              Expanded(
                                child: Obx(() {
                                  if (homeController.isSearching.value) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  if (homeController.searchList.isEmpty) {
                                    return Center(
                                      child: Text(
                                        homeController
                                                .searchController.text.isEmpty
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
                                      final user =
                                          homeController.searchList[index];
                                      return GestureDetector(
                                        onTap: () async {
                                          var chatRoomId = await homeController
                                              .createChatRoom(
                                                  Get.find<AuthController>()
                                                          .userModel
                                                          ?.name ??
                                                      "",
                                                  user.name ?? "");

                                          Map<String, dynamic> chatInfoMap = {
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
                                        child: PersonContainer(user: user),
                                      );
                                    },
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 6),
                                    itemCount: homeController.searchList.length,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                  );
                                }),
                              ),
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
