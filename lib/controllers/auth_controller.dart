import 'dart:developer';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:lekra/data/models/user_model.dart';
import 'package:lekra/firebase/firebase_auth.dart';
import 'package:lekra/firebase/firebase_database/auth_database.dart';
import 'package:lekra/services/constants.dart';
import '../data/repositories/auth_repo.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool isLoading = false;
  bool _acceptTerms = true;

  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  bool get acceptTerms => _acceptTerms;

  Future<bool> fetchProfile(String? id) async {
    log("--------------- fetchProfile (String $id)---------------");
    isLoading = true;
    update();

    try {
      _userModel = await AuthDatabase().fetchProfile(id);
      isLoading = false;
      update();

      return true;
    } catch (e) {
      log("  fetchProfile()  : Error : ${e.toString()}");
      showToast(message: e.toString(), toastType: ToastType.error);
      isLoading = false;
      update();
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      await FirebaseAuthService.signOut();
      clearSharedData();
      update();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setToken(String token) async {
    try {
      await authRepo.setUserToken(token);
      return true;
    } catch (e) {
      return false;
    }
  }

  void toggleTerms() {
    _acceptTerms = !_acceptTerms;
    update();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }
}
