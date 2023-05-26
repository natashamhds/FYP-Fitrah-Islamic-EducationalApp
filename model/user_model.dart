import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String name;
  final String email;
  final String? imageURL;
  // final String password;

  const UserModel(
      {this.id,
      required this.name,
      required this.email,
      this.imageURL
      // required this.password
      });

  toJson() {
    return {"name": name, "email": email, "image": imageURL
    // "password": password
    };
  }

  // Map user fetched from Firebase to UserModel
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        id: document.id,
        name: data['name'],
        email: data['email'],
        imageURL: data['image']
        // password: data['password']
        );
  }
}
