import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lekra/data/models/user_model.dart';

class AuthDatabase {
  Future addUser(UserModel user, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(user.toJson());
  }
}
