import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitrah/pages/Course/course_akhlak.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CourseCard extends StatelessWidget {
  const CourseCard(
      {super.key,
      this.animation,
      required this.documentSnapshot,
      required this.title,
      required this.image,
      required this.bio,
      required this.endColor,
      this.onTap});

  final Function()? onTap;
  final Animation<double>? animation; 
  final String bio;
  final DocumentSnapshot documentSnapshot;
  final String image;
  final String endColor;
  final String title;

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
      child: Stack(children: [
        Container(
          margin: const EdgeInsets.only(right: 15, top: 10),
          width: 200,
          height: 275,
          decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: HexColor(endColor).withOpacity(0.6),
                    blurRadius: 8.0,
                    offset: const Offset(1.1, 4.0))
              ],
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(54.0),
              ),
              gradient: LinearGradient(
                  colors: [HexColor('#FE95B6'), HexColor(endColor)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: Padding(
              padding: const EdgeInsets.only(
                  top: 80, left: 16, right: 16, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontFamily: 'circe',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 0.2,
                          color: Colors.white)),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(bio,
                                  style: const TextStyle(
                                      fontFamily: 'circe',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      letterSpacing: 0.2,
                                      color: Colors.white))
                            ],
                          )))
                ],
              )),
        ),
        Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
            )),
        Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 88,
              height: 80,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/$image'))),
            ))
      ]),
    );
  }
}
