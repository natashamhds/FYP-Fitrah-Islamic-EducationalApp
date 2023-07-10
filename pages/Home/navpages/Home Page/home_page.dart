import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitrah/config/configScheme.dart';
import 'package:fitrah/pages/Quiz/welcome_quiz.dart';
import 'package:fitrah/widgets/app_text.dart';
import 'package:fitrah/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Quizcard extends StatelessWidget {
  const Quizcard(
      {super.key,
      required this.documentSnapshot,
      required this.title,
      required this.image,
      this.onTap});

  final Function()? onTap;
  final DocumentSnapshot documentSnapshot;
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => askNamaAnak(context, documentSnapshot),
      child: Container(
        margin: const EdgeInsets.only(right: 30),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage('assets/images/$image'),
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

void askNamaAnak(
    BuildContext context, DocumentSnapshot documentSnapshot) async {
  final nameController = TextEditingController();
  await AwesomeDialog(
    context: context,
    dialogBorderRadius: BorderRadius.circular(20),
    dialogType: DialogType.question,
    animType: AnimType.bottomSlide,
    transitionAnimationDuration: 1100.ms,
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
      final childName = nameController.text.trim();
      if (childName.isNotEmpty) {
        navigateToWelcomeQuiz(context, documentSnapshot, childName);
      }
    },
    btnOkText: "SIMPAN",
    btnOkColor: darkBlue,
    showCloseIcon: false,
  ).show();
}

void navigateToWelcomeQuiz(
    BuildContext context, DocumentSnapshot documentSnapshot, String childName) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => WelcomeQuiz(
              documentSnapshot: documentSnapshot,
              title: documentSnapshot['title'],
              image: documentSnapshot['image'],
              childName: childName)));
}
