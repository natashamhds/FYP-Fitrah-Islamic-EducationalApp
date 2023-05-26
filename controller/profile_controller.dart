import 'package:fitrah/model/user_model.dart';
import 'package:fitrah/repository/auth_repository.dart';
import 'package:fitrah/repository/user_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final email = TextEditingController();
  final name = TextEditingController();
  // final password = TextEditingController();

  final _authRepo = Get.put(AuthRepository());
  final _userRepo = Get.put(UserRepository());

  // Get user email and name to UserRepository to fetch user record
  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null){
      return _userRepo.getUserDetails(email);
    }
    else {
      Get.snackbar("Ralat", "Sila log masuk");
    }
  }

  // Fetch list of user records
  Future<List<UserModel>> getAllUsers() async => await _userRepo.allUsers();

  updateDetails(UserModel user) async {
    await _userRepo.updateUserDetails(user);
  }
}
