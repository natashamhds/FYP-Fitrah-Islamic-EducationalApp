import 'package:fitrah/config/configScheme.dart';
import 'package:fitrah/model/jawi_model.dart';
import 'package:fitrah/pages/Home/main_page.dart';
import 'package:fitrah/widgets/app_large_text.dart';
import 'package:fitrah/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseJawi extends StatefulWidget {
  const CourseJawi({super.key});

  @override
  State<CourseJawi> createState() => _CourseJawiState();
}

class _CourseJawiState extends State<CourseJawi> {
  int currentIndex = 0; // Tracks the index of the current image being displayed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightBlue,
        appBar: AppBar(
          title: const Text("JAWI",
              style: TextStyle(color: Colors.black, fontFamily: 'circe')),
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
          height: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              )),
          child: Column(children: [
            const SizedBox(height: 20),
            AppLargeText(text: "CARA MENULIS", size: 25, color: darkBlue),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Stack(children: [
                Container(
                  height: MediaQuery.of(context).size.width * 1.20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: const Color(0XFFe6ede1),
                      border: Border.all(color: darkBlue, width: 5),
                      image: DecorationImage(
                          image: AssetImage(imageList[currentIndex].imagePath),
                          fit: BoxFit.contain)),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: CupertinoButton(
                      child: Icon(CupertinoIcons.speaker_2_fill,
                          color: darkBlue.withOpacity(1), size: 38),
                      onPressed: () {},
                    ))
              ]),
            ),
            const SizedBox(height: 20),
            AppText(
                text: imageList[currentIndex].huruf.toUpperCase(), size: 30),
            const SizedBox(height: 20),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 15,
                      color: Colors.black.withOpacity(0.1),
                    )),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: darkBlue,
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        currentIndex = (currentIndex+1) % imageList.length;
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ]),
        ));
  }
}
