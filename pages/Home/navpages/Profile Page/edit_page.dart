import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitrah/config/configScheme.dart';
import 'package:fitrah/controller/profile_controller.dart';
import 'package:fitrah/model/user_model.dart';
import 'package:fitrah/pages/Home/navpages/Profile%20Page/my_page.dart';
import 'package:fitrah/widgets/my_button.dart';
import 'package:fitrah/widgets/my_textfield1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final controller = Get.put(ProfileController());
  final currentUser = FirebaseAuth.instance.currentUser;
  File? image;
  String imageURL = '';
  Future<UserModel>? userData;

  void successEdit() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: AwesomeSnackbarContent(
        title: "Kemaskini akaun berjaya",
        message: "Akaun anda berjaya dikemaskini",
        color: Colors.lightGreen,
        contentType: ContentType.success,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  void deleteCachedImage() {
    CachedNetworkImage.evictFromCache('${currentUser?.photoURL}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      appBar: AppBar(
        title: const Text("KEMASKINI AKAUN",
            style: TextStyle(color: Colors.black, fontFamily: 'circe')),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => {
            Navigator.pop(context,
                MaterialPageRoute(builder: (context) => const MyPage())),
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: FutureBuilder(
              future: controller.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    UserModel user = snapshot.data as UserModel;
                    final id = TextEditingController(text: user.id);
                    final email = TextEditingController(text: user.email);
                    final name = TextEditingController(text: user.name);

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        GestureDetector(
                          onTap: () async {
                            // Pick an image from the gallery
                            ImagePicker imagePicker = ImagePicker();
                            XFile? file = await imagePicker.pickImage(
                                source: ImageSource.gallery);
                            image = File(file!.path);
                            setState(() {});

                            // ignore: unnecessary_null_comparison
                            if (file == null) return;
                            // Create a unique name for the image to be uploaded
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            // Upload the image to Firebase storage
                            // Get a reference to storage root
                            Reference reference = FirebaseStorage.instance
                                .ref()
                                .child('user_images');

                            // Create a reference for the image to be stored
                            Reference referenceImageToUpload =
                                reference.child(uniqueFileName);

                            // Check whether the upload process is successfull or unsuccessful
                            try {
                              // Store the image URL inside the corresponding document of the database
                              await referenceImageToUpload
                                  .putFile(File(file.path));

                              // Get the download URL of the uploaded image
                              imageURL = await referenceImageToUpload
                                  .getDownloadURL();
                            } catch (error) {
                              // Some errors occured
                            }
                          },
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl: '${currentUser?.photoURL}',
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(
                                        color: darkBlue),
                                cacheManager: CacheManager(Config(
                                    'customCacheKey',
                                    stalePeriod: const Duration(days: 2))),
                                imageBuilder: (context, imageProvider) {
                                  return SizedBox(
                                      height: 120,
                                      width: 120,
                                      // Display the image
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: image != null
                                              ? Image.file(image!)
                                              : Image(image: imageProvider)));
                                },
                              ),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: yellow),
                                    child: const Icon(Icons.create_rounded,
                                        color: Colors.black, size: 20),
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),

                        // name textfield
                        MyTextField1(
                          controller: name,
                          labelText: "Nama",
                          obscureText: false,
                          icon: Icon(
                            Icons.person,
                            color: darkBlue,
                          ),
                        ),
                        const SizedBox(height: 25),

                        // e-Mail textfield
                        MyTextField1(
                          controller: email,
                          labelText: "e-Mel",
                          obscureText: false,
                          icon: Icon(Icons.mail, color: darkBlue),
                        ),
                        const SizedBox(height: 25),

                        // save button
                        MyButton(
                            onTap: () async {
                              // display loading circle
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                        color: darkBlue),
                                  );
                                },
                              );

                              final userData = UserModel(
                                  id: id.text,
                                  name: name.text.trim(),
                                  email: email.text.trim(),
                                  imageURL: imageURL.trim()
                                  // password: password.text.trim()
                                  );

                              await controller.updateDetails(userData);

                              if (imageURL == '') {
                                currentUser
                                    ?.updateDisplayName(name.text.trim());
                                currentUser?.updateEmail(email.text.trim());
                                // currentUser?.updatePassword(password.text.trim());
                              } else {
                                currentUser
                                    ?.updateDisplayName(name.text.trim());
                                currentUser?.updateEmail(email.text.trim());
                                // Store the image URL inside of the corresponding document of the database
                                currentUser?.updatePhotoURL(imageURL.trim());
                              }

                              // pop the loading circle
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              // display success message to the user and head to the my page back
                              successEdit();
                            },
                            text: "SIMPAN"),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.toString()));
                  } else {
                    return const Center(
                        child: Text("Uh-oh, ada sesuatu yang tidak kena!"));
                  }
                } else {
                  return Center(
                      child: CircularProgressIndicator(color: darkBlue));
                }
              }),
        ),
      ),
    );
  }
}
