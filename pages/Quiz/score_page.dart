import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitrah/config/configScheme.dart';
import 'package:fitrah/pages/Home/main_page.dart';
import 'package:fitrah/widgets/app_large_text.dart';
import 'package:fitrah/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({
    Key? key,
    required this.title,
    required this.result,
    required this.questionLength,
  }) : super(key: key);

  final String title;

  final int result;
  final int questionLength;

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  final confettiController = ConfettiController();
  AudioPlayer audio = AudioPlayer();

  @override
  void dispose() {
    super.dispose();
    confettiController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    audio.setAsset('asset/audio/Yay!.mp3');
    
    return Scaffold(
      backgroundColor: lightBlue,
      appBar: AppBar(
        title: const Text("MARKAH",
            style: TextStyle(color: Colors.black, fontFamily: 'circe')),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MainPage()));
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(25)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConfettiWidget(
              confettiController: confettiController,
              blastDirection: -pi / 2,
              shouldLoop: true,
              gravity: 0.01,
              emissionFrequency: 0.01,
            ),
            AppLargeText(text: "TAHNIAH !"),
            const SizedBox(height: 18),
            Container(
              width: size.width,
              height: size.width * 0.56,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('asset/images/success.png'),
                      fit: BoxFit.contain)),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: lightBlue, borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: lighterlightBlue,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "${((widget.result / widget.questionLength) * 100).toInt()}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text("Markah",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18))
                          ],
                        ),
                      ),
                    ),
                    AppText(text: widget.title, color: darkBlue, size: 20)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              ((widget.result / widget.questionLength) * 100).toInt() ==
                      widget.questionLength
                  ? "Hampir Menguasai!"
                  : ((widget.result / widget.questionLength) * 100) <
                          widget.questionLength
                      ? "Cuba Lagi?"
                      : "Sangat Bagus!",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    updateScore(widget.title);
    confettiController.play();
    audio.play();
  }

  Future updateScore(String score) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);
    DocumentReference docRef = userDocRef.collection('anak').doc();
    docRef.update({'score.${widget.title}': widget.result});
  }
}
