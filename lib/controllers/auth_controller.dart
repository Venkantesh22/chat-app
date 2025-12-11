import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:lekra/data/models/user_model.dart';
import '../data/repositories/auth_repo.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool _acceptTerms = true;

  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  bool get isLoading => _isLoading;

  bool get acceptTerms => _acceptTerms;

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
