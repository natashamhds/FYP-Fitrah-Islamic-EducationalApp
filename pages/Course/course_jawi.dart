import 'dart:async';

import 'package:fitrah/config/configScheme.dart';
import 'package:fitrah/model/jawi_model.dart';
import 'package:fitrah/pages/Home/main_page.dart';
import 'package:fitrah/widgets/app_large_text.dart';
import 'package:fitrah/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class CourseJawi extends StatefulWidget {
  const CourseJawi({Key? key}) : super(key: key);

  @override
  State<CourseJawi> createState() => _CourseJawiState();
}

class _CourseJawiState extends State<CourseJawi> {
  List<JawiModel> alphabetList = [
    JawiModel(
        imagePath: 'assets/images/Alif.png',
        audioPath: 'audio/Alif.mp3',
        huruf: "Alif"
        ),
    JawiModel(
        imagePath: 'assets/images/Ba.png',
        audioPath: 'audio/Ba.mp3',
        huruf: "Ba"
        ),
    JawiModel(
        imagePath: 'assets/images/Ta.png',
        audioPath: 'audio/Ta.mp3',
        huruf: "Ta"
        ),
    JawiModel(
        imagePath: 'assets/images/Sa.png',
        audioPath: 'audio/Sa.mp3',
        huruf: "Sa"
        ),
    JawiModel(
        imagePath: 'assets/images/Jim.png',
        audioPath: 'audio/Jim.mp3',
        huruf: "Jim"
        ),
    JawiModel(
        imagePath: 'assets/images/Ha.png',
        audioPath: 'audio/Ha.mp3',
        huruf: "Ha"
        ),
    JawiModel(
        imagePath: 'assets/images/Kho.png',
        audioPath: 'audio/Kho.mp3',
        huruf: "Kho"
        ),
    JawiModel(
        imagePath: 'assets/images/Dal.png',
        audioPath: 'audio/Dal.mp3',
        huruf: "Dal"
        ),
    JawiModel(
        imagePath: 'assets/images/Dzal.png',
        audioPath: 'audio/Dzal.mp3',
        huruf: "Dzal"
        ),
    JawiModel(
        imagePath: 'assets/images/Ra.png',
        audioPath: 'audio/Ra.mp3',
        huruf: "Ra"
        ),
    JawiModel(
        imagePath: 'assets/images/Zai.png',
        audioPath: 'audio/Zai.mp3',
        huruf: "Zai"
        ),
    JawiModel(
        imagePath: 'assets/images/Sin.png',
        audioPath: 'audio/Sin.mp3',
        huruf: "Sin"
        ),
    JawiModel(
        imagePath: 'assets/images/Shin.png',
        audioPath: 'audio/Shin.mp3',
        huruf: "Shin"
        ),
    JawiModel(
        imagePath: 'assets/images/Sod.PNG',
        audioPath: 'audio/Sod.mp3',
        huruf: "Sod"
        ),
    JawiModel(
        imagePath: 'assets/images/Dhod.PNG',
        audioPath: 'audio/Dhod.mp3',
        huruf: "Dhod"
        ),
    JawiModel(
        imagePath: 'assets/images/Tho.png',
        audioPath: 'audio/Tho.mp3',
        huruf: "Tho"
        ),
    JawiModel(
        imagePath: 'assets/images/Dzo.PNG',
        audioPath: 'audio/Dzo.mp3',
        huruf: "Dzo"
        ),
    JawiModel(
        imagePath: 'assets/images/Ain.png',
        audioPath: 'audio/Ain.mp3',
        huruf: "Ain"
        ),
    JawiModel(
        imagePath: 'assets/images/Ghain.png',
        audioPath: 'audio/Ghain.mp3',
        huruf: "Ghain"
        ),
    JawiModel(
        imagePath: 'assets/images/Fa.png',
        audioPath: 'audio/Fa.mp3',
        huruf: "Fa"
        ),
    JawiModel(
        imagePath: 'assets/images/Qaf.png',
        audioPath: 'audio/Qaf.mp3',
        huruf: "Qaf"
        ),
    JawiModel(
        imagePath: 'assets/images/Kaf.png',
        audioPath: 'audio/Kaf.mp3',
        huruf: "Kaf"
        ),
    JawiModel(
        imagePath: 'assets/images/Lam.png',
        audioPath: 'audio/Lam.mp3',
        huruf: "Lam"),
    JawiModel(
        imagePath: 'assets/images/Mim.png',
        audioPath: 'audio/Mim.mp3',
        huruf: "Mim"),
    JawiModel(
        imagePath: 'assets/images/Nun.png',
        audioPath: 'audio/Nun.mp3',
        huruf: "Nun"),
    JawiModel(
        imagePath: 'assets/images/Wau.png',
        audioPath: 'audio/Wau.mp3',
        huruf: "Wau"),
    JawiModel(
        imagePath: 'assets/images/Haa.png',
        audioPath: 'audio/Haa.mp3',
        huruf: "Haa"),
    JawiModel(
        imagePath: 'assets/images/Hamzah.PNG',
        audioPath: 'audio/Hamzah.mp3',
        huruf: "Hamzah"),
    JawiModel(
        imagePath: 'assets/images/Ya.png',
        audioPath: 'audio/Ya.mp3',
        huruf: "Ya")
  ];

  int currentIndex = 0; // Tracks the index of the current image being displayed
  final player = AudioPlayer();

  List<List<Offset>> tracedPaths = [];

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> playAudioFromAsset(String path) async {
    await player.play(AssetSource(path));
  }

  void goToNextAlphabet() {
    setState(() {
      currentIndex =
          (currentIndex + 1) % alphabetList.length; // Move to the next index
    });
  }

  @override
  Widget build(BuildContext context) {
    JawiModel currentAlphabet = alphabetList[currentIndex];
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
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: const Color(0XFFe6ede1),
                      border: Border.all(color: darkBlue, width: 5),
                      image: DecorationImage(
                          image: AssetImage(currentAlphabet.imagePath),
                          fit: BoxFit.contain)),
                  child: GestureDetector(
                    onPanStart: (details) {
                      setState(() {
                        tracedPaths.add([details.localPosition]);
                      });
                    },
                    onPanUpdate: (details) {
                      setState(() {
                        tracedPaths.last.add(details.localPosition);
                      });
                    },
                    onPanEnd: (details) {
                      // Finger movement ended
                    },
                    child: CustomPaint(
                      painter: TracingPainter(tracedPaths),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: CupertinoButton(
                      child: Icon(CupertinoIcons.speaker_2_fill,
                          color: darkBlue.withOpacity(1), size: 38),
                      onPressed: () {
                        playAudioFromAsset(currentAlphabet.audioPath);
                      },
                    )),
                Positioned(
                    bottom: 0,
                    left: 0,
                    child: CupertinoButton(
                        child: Icon(CupertinoIcons.arrow_clockwise,
                            color: darkBlue.withOpacity(1), size: 40),
                        onPressed: () {
                          setState(() {
                            tracedPaths.clear();
                          });
                        }))
              ]),
            ),
            const SizedBox(height: 20),
            AppText(text: currentAlphabet.huruf.toUpperCase(), size: 30),
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
                      goToNextAlphabet();
                      tracedPaths.clear();
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

class TracingPainter extends CustomPainter {
  TracingPainter(this.tracedPaths);

  final List<List<Offset>> tracedPaths;

  @override
  void paint(Canvas canvas, Size size) {
    Paint pointPaint = Paint()
      ..color = yellow
      ..strokeWidth = 12.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (var path in tracedPaths) {
      for (var point in path) {
        canvas.drawCircle(point, 8.0, pointPaint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
