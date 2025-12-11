import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lekra/data/models/user_model.dart';

class AuthDatabase {
  Future addUser(UserModel user, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(user.toJson());
  }

  Future<UserModel?> fetchProfile(String? id) async {
    if (id == null) return null;

    try {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection('users').doc(id).get();

      if (doc.exists) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
