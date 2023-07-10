import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitrah/config/configScheme.dart';
import 'package:fitrah/pages/Home/main_page.dart';
import 'package:fitrah/widgets/app_large_text.dart';
import 'package:fitrah/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CourseAkhlak extends StatefulWidget {
  const CourseAkhlak(
      {super.key, required this.title, required this.documentSnapshot});

  final DocumentSnapshot documentSnapshot;
  final String title;

  @override
  State<CourseAkhlak> createState() => _CourseAkhlakState();
}

class _CourseAkhlakState extends State<CourseAkhlak> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoID =
        YoutubePlayer.convertUrlToId(widget.documentSnapshot['link']);
    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(
            autoPlay: false, forceHD: true, enableCaption: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      appBar: AppBar(
        title: const Text("AKHLAK",
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
      body: SingleChildScrollView(
        child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40))),
            child: Column(children: [
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: AppLargeText(
                    text: widget.documentSnapshot['title'].toUpperCase(),
                    size: 25,
                    color: darkBlue),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  bottomActions: [
                    CurrentPosition(),
                    ProgressBar(
                      isExpanded: true,
                      colors: ProgressBarColors(
                          playedColor: yellow, handleColor: yellow),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9.0),
                child: Column(
                  children: [
                    AppText(
                        text: widget.documentSnapshot['description']
                            .replaceAll('\\n', '\n'),
                        size: 25),
                    const SizedBox(height: 20),
                    Text(widget.documentSnapshot['doa title'],
                        style: const TextStyle(fontSize: 18)),
                    Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: yellow,
                            borderRadius: BorderRadius.circular(15)),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: AppText(
                                text: (widget.documentSnapshot.data()
                                        as Map)['doa'] ??
                                    '',
                                size: 25))),
                    const SizedBox(height: 10),
                    const Text("Rumi:", style: TextStyle(fontSize: 18)),
                    Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.pink.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(15)),
                        child: Align(
                            alignment: Alignment.center,
                            child: AppText(
                                text: (widget.documentSnapshot.data()
                                        as Map)['doa rumi'] ??
                                    '',
                                size: 22))),
                    const SizedBox(height: 10),
                    const Text("Maksudnya:", style: TextStyle(fontSize: 18)),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: purple.withOpacity(0.45),
                          borderRadius: BorderRadius.circular(15)),
                      child: Align(
                        alignment: Alignment.center,
                        child: AppText(
                            text: (widget.documentSnapshot.data()
                                    as Map)['maksud doa'] ??
                                '',
                            size: 22),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if ((widget.documentSnapshot.data() as Map<String, dynamic>)
                        .containsKey(
                            'doa1')) // check whether the documentSnapshot has 2 doa field
                      Column(
                        children: [
                          Text(widget.documentSnapshot['doa title1'],
                              style: const TextStyle(fontSize: 18)),
                          Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: yellow,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: AppText(
                                      text: (widget.documentSnapshot.data()
                                              as Map)['doa1'] ??
                                          '',
                                      size: 25))),
                          const SizedBox(height: 10),
                          const Text("Rumi:", style: TextStyle(fontSize: 18)),
                          Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.pink.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: AppText(
                                      text: (widget.documentSnapshot.data()
                                              as Map)['doa rumi1'] ??
                                          '',
                                      size: 22))),
                          const SizedBox(height: 10),
                          const Text("Maksudnya:",
                              style: TextStyle(fontSize: 18)),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: purple.withOpacity(0.45),
                                borderRadius: BorderRadius.circular(15)),
                            child: Align(
                              alignment: Alignment.center,
                              child: AppText(
                                  text: (widget.documentSnapshot.data()
                                          as Map)['maksud doa1'] ??
                                      '',
                                  size: 22),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              )
            ])),
      ),
    );
  }
}
