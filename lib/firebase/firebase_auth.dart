import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/data/models/user_model.dart';
import 'package:lekra/firebase/firebase_database/auth_database.dart';

class FirebaseAuthService {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<bool> signInWithGoogle() async {
    try {
      await GoogleSignIn.instance.initialize(
        serverClientId:
            '252507782720-87ui6a7ig0c3sv2btb13sqk842s3v9k8.apps.googleusercontent.com',
      );

      final googleUser = await GoogleSignIn.instance.authenticate();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCred = await auth.signInWithCredential(credential);
      final user = userCred.user;
      if (user != null) {
        UserModel userModel = UserModel(
          name: user.displayName,
          email: user.email,
          image: user.photoURL,
          id: user.uid,
        );

        await AuthDatabase().addUser(userModel, user.uid);
        Get.find<AuthController>().setToken(googleAuth.idToken ?? "");
      }
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> signOut() async {
    await auth.signOut();
    await GoogleSignIn.instance.signOut();
    return true;
  }
}
