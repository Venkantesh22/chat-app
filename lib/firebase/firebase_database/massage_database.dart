import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class MassageDatabase {
  static final firebase = FirebaseFirestore.instance;

  Future addMessage(String charRoomId, String messageId,
      Map<String, dynamic> messageInfoMap) async {
    return await firebase
        .collection('Chatroom')
        .doc(charRoomId)
        .collection('chats')
        .doc(messageId)
        .set(messageInfoMap);
  }

  Future updateLastMessageSend(
      String charRoomId, Map<String, dynamic> lastMessageInfoMap) async {
    return await firebase
        .collection('Chatroom')
        .doc(charRoomId)
        .update(lastMessageInfoMap);
  }

  static Future<QuerySnapshot> searchUser(String username) async {
    if (username.isEmpty) {
      return await firebase.collection('users').limit(0).get();
    }

    return await firebase
        .collection('users')
        .where("searchKey", isEqualTo: username.substring(0, 1).toLowerCase())
        .get();
  }

  static Future<QuerySnapshot> searchUserByName(String username) async {
    if (username.isEmpty) {
      return await firebase.collection('users').limit(0).get();
    }

    return await firebase
        .collection('users')
        .where("userName", isGreaterThanOrEqualTo: username.toLowerCase())
        .where("userName", isLessThan: username.toLowerCase() + 'z')
        .get();
  }

  Future<bool> createChatRoom(
      String chatRoomId, Map<String, dynamic> chatRoomInfoMap) async {
    try {
      final snapshot =
          await firebase.collection('Chatroom').doc(chatRoomId).get();
      if (snapshot.exists) {
        return true;
      } else {
        firebase.collection('Chatroom').doc(chatRoomId).set(chatRoomInfoMap);
        return true;
      }
    } on Exception catch (e) {
      log("--createChatRoom : Error : ${e.toString()}");
      return false;
    }
  }

  Future<Stream<QuerySnapshot>> getChatRoomMessage(chatRoomId) async {
    
    return await firebase
        .collection("Chatroom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time', descending: true)
        .snapshots();
  }
}
