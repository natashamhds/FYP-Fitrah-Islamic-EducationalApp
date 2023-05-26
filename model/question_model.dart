import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Question {
  final String id;
  final String question;
  final List<String> answers;
  final String correctAnswer;
  Question({
    required this.id,
    required this.question,
    required this.answers,
    required this.correctAnswer,
  });

  Question copyWith({
    String? id,
    String? question,
    List<String>? answers,
    String? correctAnswer,
  }) {
    return Question(
      id: id ?? this.id,
      question: question ?? this.question,
      answers: answers ?? this.answers,
      correctAnswer: correctAnswer ?? this.correctAnswer,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'question': question});
    result.addAll({'answers': answers});
    result.addAll({'correctAnswer': correctAnswer});

    return result;
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] ?? '',
      question: map['question'] ?? '',
      answers: List<String>.from(map['answers']),
      correctAnswer: map['correctAnswer'] ?? '',
    );
  }

  factory Question.fromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final id = snapshot.id;
    data['id'] = id;
    return Question.fromMap(data);
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Question1(id: $id, question: $question, answers: $answers, correctAnswer: $correctAnswer)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Question &&
        other.id == id &&
        other.question == question &&
        listEquals(other.answers, answers) &&
        other.correctAnswer == correctAnswer;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        question.hashCode ^
        answers.hashCode ^
        correctAnswer.hashCode;
  }
}

// List<Question1> question1 = [
//   Question1(
//       id: "1",
//       question:
//           "Maksud berdoa adalah perbuatan hamba memohon sesuatu kepada ___?",
//       answers: ["bapa", "Allah", "manusia"],
//       correctAnswer: "Allah"),
//   Question1(
//       id: "2",
//       question: "Apakah antara adab berdoa?",
//       answers: [
//         "Berdoa di dalam tandas",
//         "Berdoa untuk keburukan orang lain",
//         "Mengangkat kedua-kedua belah tangan semasa berdoa"
//       ],
//       correctAnswer: "Mengangkat kedua-kedua belah tangan semasa berdoa"),
//   Question1(
//       id: "3",
//       question: "Apakah kepentingan mengamalkan adab berdoa?",
//       answers: [
//         "Membentuk sikap berusaha dan bersungguh-sungguh",
//         "Membentuk sikap sombong dengan manusia lain",
//         "Tidak berharap dengan Allah"
//       ],
//       correctAnswer: "Membentuk sikap berusaha dan bersungguh-sungguh"),
//   Question1(
//       id: "4",
//       question: "Sewaktu berdoa, kita perlu ___?",
//       answers: ["memuji Allah", "mencaci Allah"],
//       correctAnswer: "memuji Allah")
// ];
