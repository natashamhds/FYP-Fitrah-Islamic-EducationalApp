import 'package:fitrah/config/configScheme.dart';
import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard(
      {Key? key,
      required this.question,
      required this.indexAction,
      required this.totalQuestions})
      : super(key: key);

  final String question;
  final int indexAction;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          RichText(
              text: TextSpan(children: <TextSpan>[
            TextSpan(
                text: "Soalan ${indexAction + 1}",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: darkBlue)),
            TextSpan(
                text: "/$totalQuestions",
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    color: darkBlue)),
          ])),
          const SizedBox(height: 13),
          Text(
            question,
            style: const TextStyle(fontSize: 24, fontFamily: 'circe'),
          ),
          const SizedBox(height: 13),
          Divider(color: darkBlue),
        ],
      ),
    );
  }
}
