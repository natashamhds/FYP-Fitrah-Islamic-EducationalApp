import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitrah/config/configScheme.dart';
import 'package:fitrah/pages/Login/login_page.dart';
import 'package:fitrah/pages/auth_page.dart';
import 'package:fitrah/widgets/my_button.dart';
import 'package:fitrah/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isObscure = true;
  bool isObscure1 = true;
  // text editing controllers - to keep track of what's inside when user types
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String imageURL = '';
  File? image;

  // sign user up method
  void signUp() async {
    // display loading circle
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(color: darkBlue),
        );
      },
    );

    // try creating the user
    try {
      // check if password is confirmed
      if (passwordController.text == confirmPasswordController.text) {
        // create user
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());

        FirebaseAuth.instance.currentUser!
            .updateDisplayName(nameController.text.trim());
        FirebaseAuth.instance.currentUser!.updatePhotoURL(imageURL.trim());
        // add user's details to the database
        addUserDetails(nameController.text.trim(), emailController.text.trim(), imageURL.trim());
        // await AddSubCollection();

        // display success message to the user and head to the login page
        successRegistered();
      } else {
        // display error message
        wrongConfirmPasswordMessage();
      }
    } on FirebaseAuthException catch (e) {
      // email already being used
      if (e.code == 'email-already-in-use') {
        // display error to the user
        emailAlreadyInUse();
      }
      // weak password
      else if (e.code == 'weak-password') {
        // display error to the user
        weakPassword();
      }
      // invalid e-Mail
      else if (e.code == 'invalid-email') {
        // display error to the user
        invalidEmail();
      }
      // pop the loading circle
      Navigator.pop(context);
    }
    // pop the loading circle
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    // head to the main page after successful registration
    // ignore: use_build_context_synchronously
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AuthPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          //the first icon always named as leading
          onPressed: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage()))
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Selamat Datang!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                    fontFamily: 'circe'),
              ).animate().fade(duration: 1300.ms).slide(),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Kami teruja anda ingin belajar bersama kami!",
                style: TextStyle(fontSize: 17.9, fontFamily: 'circe'),
              ),
              const SizedBox(height: 25),
              GestureDetector(
                onTap: () async {
                  // Pick an image from the gallery
                  ImagePicker imagePicker = ImagePicker();
                  XFile? file =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  image = File(file!.path);
                  setState(() {});

                  // ignore: unnecessary_null_comparison
                  if (file == null) return;
                  // Create a unique name for the image to be uploaded
                  String uniqueFileName =
                      DateTime.now().millisecondsSinceEpoch.toString();

                  // Upload the image to Firebase storage
                  // Get a reference to storage root
                  Reference reference =
                      FirebaseStorage.instance.ref().child('user_images');

                  // Create a reference for the image to be stored
                  Reference referenceImageToUpload =
                      reference.child(uniqueFileName);

                  // Check whether the upload process is successfull or unsuccessful
                  try {
                    // Store the image URL inside the corresponding document of the database
                    await referenceImageToUpload.putFile(File(file.path));

                    // Get the download URL of the uploaded image
                    imageURL = await referenceImageToUpload.getDownloadURL();
                  } catch (error) {
                    // Some errors occured
                  }
                },
                child: Stack(
                  children: [
                    SizedBox(
                        width: 120,
                        height: 120,
                        // Display the image
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: image != null
                              ? Image.file(image!)
                              : const Image(
                                  image:
                                      AssetImage('asset/images/boy1.png')),
                        )),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: yellow),
                          child: const Icon(Icons.add_a_photo_rounded,
                              color: Colors.black, size: 20),
                        ))
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // name textfield
              MyTextField(
                controller: nameController,
                labelText: "Nama",
                obscureText: false,
                icon: Icon(
                  Icons.person,
                  color: darkBlue,
                ),
              ),

              const SizedBox(height: 10),

              // e-Mail textfield
              MyTextField(
                controller: emailController,
                labelText: "e-Mel",
                obscureText: false,
                icon: Icon(
                  Icons.mail,
                  color: darkBlue,
                ),
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                  controller: passwordController,
                  labelText: "Kata laluan",
                  obscureText: isObscure,
                  icon: Icon(
                    Icons.lock,
                    color: darkBlue,
                  ),
                  icon1: IconButton(
                      icon: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off,
                          color: darkBlue),
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      })),

              const SizedBox(height: 10),

              // confirm password textfield
              MyTextField(
                  controller: confirmPasswordController,
                  labelText: "Kata laluan",
                  obscureText: isObscure1,
                  icon: Icon(
                    Icons.lock,
                    color: darkBlue,
                  ),
                  icon1: IconButton(
                      icon: Icon(
                          isObscure1 ? Icons.visibility : Icons.visibility_off,
                          color: darkBlue),
                      onPressed: () {
                        setState(() {
                          isObscure1 = !isObscure1;
                        });
                      })),

              const SizedBox(height: 25),

              // sign up button
              MyButton(
                text: "DAFTAR MASUK",
                onTap: signUp,
              ),
            ],
          ),
        ),
      )),
    );
  }

  void wrongConfirmPasswordMessage() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: AwesomeSnackbarContent(
        title: "Kata laluan tidak sepadan",
        message: "Sila pastikan kata laluan anda sepadan",
        color: Colors.yellow,
        contentType: ContentType.warning,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const RegisterPage()));
  }

  void emailAlreadyInUse() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: AwesomeSnackbarContent(
        title: "e-Mel sudah digunakan",
        message: "Sila isi e-Mel yang lain",
        color: Colors.yellow,
        contentType: ContentType.warning,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const RegisterPage()));
  }

  void weakPassword() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: AwesomeSnackbarContent(
        title: "Kata laluan lemah",
        message: "Kata laluan mesti melebihi daripada 6 karakter",
        color: Colors.yellow,
        contentType: ContentType.warning,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const RegisterPage()));
  }

  void invalidEmail() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: AwesomeSnackbarContent(
        title: "e-Mel tidak sah",
        message: "Sila isi e-Mel yang sah",
        color: Colors.yellow,
        contentType: ContentType.warning,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
    // stay at the register page if failure
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const RegisterPage()));
  }

  void successRegistered() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: AwesomeSnackbarContent(
        title: "Pendaftaran akaun berjaya",
        message: "Anda kini boleh menggunakan aplikasi",
        color: Colors.lightGreen,
        contentType: ContentType.success,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  Future addUserDetails(String name, String email, String image) async {
    await FirebaseFirestore.instance
        .collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'name': name, 'email': email, 'image': imageURL});
  }
  
  // Future AddSubCollection() async {
  //   await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('anak').add({
  //     'nama' : 'Sasa'
  //   });
  // }
}
