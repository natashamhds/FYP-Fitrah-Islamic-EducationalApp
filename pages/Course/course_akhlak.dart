import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitrah/config/configScheme.dart';
import 'package:fitrah/pages/Home/main_page.dart';
import 'package:fitrah/widgets/app_large_text.dart';
import 'package:fitrah/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CourseAkhlak extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  final String title;

  const CourseAkhlak({super.key, required this.title, required this.documentSnapshot});

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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40), topLeft: Radius.circular(40))),
        child: Column(children: [
          const SizedBox(height: 20),
          AppLargeText(
              text: widget.documentSnapshot['title'].toUpperCase(),
              size: 25,
              color: darkBlue),
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
          AppText(
              text: widget.documentSnapshot['description'].replaceAll('\\n', '\n'), size: 25),
          // StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          //   stream: FirebaseFirestore.instance
          //       .collection('courses')
          //       .doc(widget.title)
          //       .snapshots(),
          //   builder: (BuildContext context,
          //       AsyncSnapshot<DocumentSnapshot> snapshot) {
          //     if (snapshot.hasError) {
          //       return const Text('Something went wrong');
          //     }
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Text("Loading");
          //     }
          //     Map<String, dynamic> data =
          //         snapshot.data!.data()! as Map<String, dynamic>;
          //     return ListView(
          //         children: data['arrayOfString'].map<Widget>((e) {
          //       return ListTile(
          //         title: Text(e.toString()),
          //       );
          //     }).toList());
          //   },
          // ),
        ]),
      ),
    );
  }
}
