import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/data/models/user_model.dart';
import 'package:lekra/firebase/firebase_database/massage_database.dart';

class HomeController extends GetxController implements GetxService {
  bool isloading = false;

  TextEditingController searchController = TextEditingController();

  createChatRoom(String yourName, String chatWithUser) async {
    if (yourName.substring(0, 1).codeUnitAt(0) >
        chatWithUser.substring(0, 1).codeUnitAt(0)) {
      return "$chatWithUser\_$yourName";
    } else {
      return "$yourName\_$chatWithUser";
    }
  }

  RxList<UserModel> searchList = <UserModel>[].obs;
  RxBool isSearching = false.obs;

  Future<void> searchUser(String query) async {
    if (query.isEmpty) {
      searchList.clear();
      return;
    }

    try {
      isSearching.value = true;

      final querySnapshotByKey = await MassageDatabase.searchUser(query);

      final querySnapshotByName = await MassageDatabase.searchUserByName(query);

      final Map<String, UserModel> uniqueUsers = {};

      for (var doc in querySnapshotByKey.docs) {
        final user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
        uniqueUsers[user.id ?? ''] = user;
      }

      for (var doc in querySnapshotByName.docs) {
        final user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
        uniqueUsers[user.id ?? ''] = user;
      }

      searchList.value = uniqueUsers.values.toList();
      isSearching.value = false;
    } catch (e) {
      isSearching.value = false;
      print('Search error: $e');
    }
  }

  UserModel? selectPersonForChat;

  void setSelectPersonForChat({required UserModel? value}) {
    selectPersonForChat = value;
    update();
  }
}
