import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitrah/config/configScheme.dart';
import 'package:fitrah/model/question_model.dart';
import 'package:fitrah/pages/Home/main_page.dart';
import 'package:fitrah/pages/Quiz/quiz_page.dart';
import 'package:fitrah/widgets/app_text.dart';
import 'package:fitrah/widgets/my_button.dart';
import 'package:flutter/material.dart';

class WelcomeQuiz extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  final String title;
  final String image;

  const WelcomeQuiz({
    super.key,
    required this.title,
    required this.documentSnapshot,
    required this.image,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightBlue,
        appBar: AppBar(
          title: Text(documentSnapshot['title'].toUpperCase(),
              style: const TextStyle(color: Colors.black, fontFamily: 'circe')),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => const MainPage()));
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
        body: Column(children: [
          const SizedBox(height: 70),
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(25),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        // margin: const EdgeInsets.only(right: 50),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage("asset/images/$image"),
                                fit: BoxFit.cover)),
                      ),
                      const SizedBox(height: 20),
                      AppText(text: "${documentSnapshot['title']}", size: 30),
                      const SizedBox(height: 20),
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('quiz $title')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child:
                                    CircularProgressIndicator(color: darkBlue),
                              );
                            }
                            final questionDocs = snapshot.data!.docs;
                            final questions = questionDocs
                                .map((e) =>
                                    Question.fromQueryDocumentSnapshot(e))
                                .toList();
                            return MyButton(
                                onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => QuizPage(
                                                  documentSnapshot:
                                                      documentSnapshot,
                                                  question: questions)))
                                    },
                                text: "MULAKAN");
                          }),
                    ],
                  ),
                )),
          )
        ]));
  }
}
