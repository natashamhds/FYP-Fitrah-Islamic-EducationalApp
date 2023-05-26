import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitrah/config/configScheme.dart';
import 'package:fitrah/pages/Quiz/welcome_quiz.dart';
import 'package:fitrah/widgets/app_text.dart';
import 'package:fitrah/widgets/my_textfield.dart';
import 'package:flutter/material.dart';

class Quizcard extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  final String title;
  final String image;
  final Function()? onTap;

  const Quizcard(
      {super.key,
      required this.title,
      required this.documentSnapshot,
      required this.image,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WelcomeQuiz(
                  documentSnapshot: documentSnapshot,
                  title: title,
                  image: image)),
        ),
        askNamaAnak(context)
      },
      child: Container(
        margin: const EdgeInsets.only(right: 30),
        child: Column(
          children: [
            Container(
              // margin: const EdgeInsets.only(right: 50),
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage("asset/images/$image"),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(height: 10),
            AppText(
              text: documentSnapshot['title'],
              color: darkBlue,
            )
          ],
        ),
      ),
    );
  }
}

void askNamaAnak(context) {
  final nameController = TextEditingController();
  AwesomeDialog(
    context: context,
    dialogType: DialogType.question,
    animType: AnimType.bottomSlide,
    title: "Apakah nama kamu?",
    body: MyTextField(
        controller: nameController,
        labelText: "Nama Anak",
        obscureText: false,
        icon: Icon(
          Icons.person,
          color: darkBlue,
        )),
    desc: "Sila masukkan nama anak. Kamu tidak boleh kembali pada saat ini.",
    dismissOnTouchOutside: false,
    // dismissOnBackKeyPress: false,
    enableEnterKey: true,
    headerAnimationLoop: true,
    btnOkOnPress: () {
      Future saveNamaAnak(context) async {
        final currentUser = FirebaseAuth.instance.currentUser;
        List<dynamic> anak = [nameController.text.trim()];
        try {
          if (currentUser != null) {
            // Reference to the Firestore document of the current user
            DocumentReference documentReference = FirebaseFirestore.instance
                .collection('users')
                .doc(currentUser!.uid);
            // Update the document with the array data
            await documentReference
                .update({'data': FieldValue.arrayUnion(anak)});
          }
        } catch (e) {
          return CircularProgressIndicator(color: darkBlue);
        }
      }
    },
    btnOkText: "SIMPAN",
    btnOkColor: darkBlue,
    showCloseIcon: false,
  ).show();
}

// Future saveNamaAnak(context) async {
//   final currentUser = FirebaseAuth.instance.currentUser;
//   List<dynamic> anak = [nameController.text.trim()];
//   try {
//     if (currentUser != null) {
//       // Reference to the Firestore document of the current user
//       DocumentReference documentReference =
//           FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);
//       // Update the document with the array data
//       await documentReference.update({'data': FieldValue.arrayUnion(anak)});
//     }
//   } catch (e) {
//     return CircularProgressIndicator(color: darkBlue);
//   }
// }
