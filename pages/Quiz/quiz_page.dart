import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitrah/config/configScheme.dart';
import 'package:fitrah/model/question_model.dart';
import 'package:fitrah/pages/Home/main_page.dart';
import 'package:fitrah/pages/Quiz/score_page.dart';
import 'package:fitrah/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

import 'component/question_card.dart';

class QuizPage extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  const QuizPage(
      {super.key, required this.documentSnapshot, required this.question});

  final List<Question> question;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late int currentTime;
  late Timer timer;
  int currentIndex = 0;
  int score = 0;
  String selectedAns = '';
  bool isSelected = false;
  AudioPlayer audio = AudioPlayer();

  @override
  void initState() {
    super.initState();
    currentTime = 300;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        currentTime -= 1;
      });

      if (currentTime == 0) {
        timer.cancel();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ScorePage(
              title: widget.documentSnapshot['title'],
              result: score,
              questionLength: widget.question.length,
            ),
          ),
        );
      }
    });
    audio.setAsset('asset/audio/timer.mp3');
    audio.play();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
    audio.stop();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.question[currentIndex];

    return Scaffold(
      backgroundColor: lightBlue,
      appBar: AppBar(
        title: Text(widget.documentSnapshot['title'].toUpperCase(),
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
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(25)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
              child: SizedBox(
                  height: 30,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          LinearProgressIndicator(
                            value: currentTime / 300,
                            color: const Color.fromARGB(255, 241, 78, 132),
                            backgroundColor: pink,
                          ),
                          Center(
                              child: Text(currentTime.toString(),
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)))
                        ],
                      ))),
            ),
            const SizedBox(height: 10),
            QuestionCard(
                question: currentQuestion.question,
                indexAction: currentIndex,
                totalQuestions: widget.question.length),
            Flexible(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: currentQuestion.answers.length,
                  itemBuilder: (context, index) {
                    final answer = currentQuestion.answers[index];
                    // return Option(option: answer, color: selectedAns == answer && answer == currentQuestion.correctAnswer ? correct : neutral);
                    return AnswerTile(
                      isAlreadySelected: answer == selectedAns,
                      answer: answer,
                      correctAnswer: currentQuestion.correctAnswer,
                      onTap: () {
                        setState(() {
                          selectedAns = answer;
                        });
                        if (answer == currentQuestion.correctAnswer) {
                          score++;
                          HapticFeedback.selectionClick();
                        }
                        Future.delayed(const Duration(milliseconds: 4000), () {
                          if (currentIndex == widget.question.length - 1) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => ScorePage(
                                  title: widget.documentSnapshot['title'],
                                  result: score,
                                  questionLength: widget.question.length,
                                ),
                              ),
                            );
                            return;
                          }
                          setState(() {
                            currentIndex++;
                            selectedAns = '';
                          });
                        });
                      },
                    );
                  }),
            ),
            const SizedBox(height: 20),
            AppText(text: "Markah: $score", color: darkBlue, size: 20),
            const SizedBox(height: 13),
          ],
        ),
      ),
    );
  }
}

class AnswerTile extends StatelessWidget {
  const AnswerTile(
      {Key? key,
      required this.isAlreadySelected,
      required this.answer,
      required this.correctAnswer,
      required this.onTap})
      : super(key: key);

  final bool isAlreadySelected;
  final String answer;
  final String correctAnswer;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: cardColor, width: 5)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          onTap: () => onTap(),
          trailing: isAlreadySelected && answer == correctAnswer
              ? Icon(Icons.check, color: correct, size: 40)
              : isAlreadySelected && answer != correctAnswer
                  ? Icon(Icons.close, color: incorrect, size: 40)
                  : null,
          title: Text(
            answer,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  Color get cardColor {
    if (!isAlreadySelected) {
      return neutral;
    }
    if (answer == correctAnswer) {
      return correct;
    }
    return incorrect;
  }
}
