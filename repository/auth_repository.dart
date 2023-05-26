import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitrah/pages/Home/main_page.dart';
import 'package:fitrah/pages/Welcome/welcome_page.dart';
import 'package:get/get.dart';

class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => const WelcomePage()) : Get.offAll(() => const MainPage());
    }
}