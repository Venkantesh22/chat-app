import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lekra/controllers/home_controller.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: GetBuilder<HomeController>(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                        preFixWidget: const Icon(
                          Icons.person_2_outlined,
                          color: primaryColor,
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  navigate(
                                      context: context, page: ChatScreen());
                                },
                                child: const PersonContainer());
                          },
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 6),
                          itemCount: 10,
                          physics: const AlwaysScrollableScrollPhysics(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
