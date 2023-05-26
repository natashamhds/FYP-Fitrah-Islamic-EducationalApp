import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitrah/config/configScheme.dart';
import 'package:fitrah/pages/Course/course_akhlak.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  final String title;
  final String image;
  final Function()? onTap;

  const CourseCard(
      {super.key,
      required this.documentSnapshot,
      required this.title,
      required this.image,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CourseAkhlak(
                  documentSnapshot: documentSnapshot, title: title)),
        )
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15, top: 10),
        width: 200,
        height: 275,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                colors: [lightBlue, yellow],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            boxShadow: [
              BoxShadow(
                  color: lighterlightBlue,
                  blurRadius: 12,
                  offset: const Offset(0, 0.015))
            ]
            // color: Colors.white,
            // image: DecorationImage(
            //     image: AssetImage('asset/images/$image'), fit: BoxFit.cover)
            ),
        child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 10),
            child: Text(title,
                style: const TextStyle(
                  fontFamily: 'circe',
                  fontSize: 28,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500
                ))),
      ),
    );
  }
}
