import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitrah/model/user_model.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Fetch single user details
  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection("users").where("email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  // Fetch all user details
  Future<List<UserModel>> allUsers() async {
    final snapshot = await _db.collection("users").get();
    final userData =
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }

  // Update user details
  Future<void> updateUserDetails(UserModel user) async {
    await _db.collection("users").doc(user.id).update(user.toJson());
  }
}
