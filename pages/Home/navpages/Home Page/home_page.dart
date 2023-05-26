import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitrah/pages/Course/course_jawi.dart';
import 'package:fitrah/pages/Home/navpages/Home%20Page/course_card.dart';
import 'package:fitrah/config/configScheme.dart';
import 'package:fitrah/pages/Home/navpages/Home%20Page/quiz_card.dart';
import 'package:fitrah/widgets/app_large_text.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      backgroundColor: lightBlue,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),

            Container(
              margin: const EdgeInsets.only(left: 20),
              child: AppLargeText(text: "Apa yang anda mahu belajar hari ini?"),
            ),

            // discover text
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: AppLargeText(text: "Pembelajaran"),
            ),

            const SizedBox(
                height: 20), // create distance between up and container

            // tab bar
            Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                labelPadding: const EdgeInsets.only(left: 20, right: 20),
                controller: tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: CircleTabIndicator(color: darkBlue, radius: 4),
                // tukar indicator size to circle by creating a class that passes decoration class
                tabs: const [
                  Tab(
                    text: "Akhlak",
                  ),
                  Tab(
                    text: "Jawi",
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              height: 275,
              width: double.maxFinite,
              child: TabBarView(
                controller: tabController,
                children: [
                  // Pembelajaran Akhlak
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('courses')
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data?.docs.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                DocumentSnapshot documentSnapshot =
                                    snapshot.data.docs[index];

                                return CourseCard(
                                  title: documentSnapshot['title'],
                                  image: documentSnapshot['image'],
                                  documentSnapshot: documentSnapshot,
                                );
                              });
                        } else {
                          return Center(
                            child:
                                CircularProgressIndicator(color: darkBlue),
                          );
                        }
                      }),
                  // Pembelajaran Jawi
                  ListView.builder(
                      itemCount: 1,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CourseJawi()),
                            )
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 15, top: 10),
                            width: 200,
                            height: 275,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "asset/images/female_quran.png"),
                                    fit: BoxFit.cover)),
                          ),
                        );
                      })
                ],
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppLargeText(
                    text: "Kuiz",
                    size: 22,
                  ),
                  // AppText(text: "Lihat semua", color: purple)
                ],
              ),
            ),

            const SizedBox(height: 10),

            Container(
              height: 120,
              width: double.maxFinite,
              margin: const EdgeInsets.only(left: 20),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('courses')
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot documentSnapshot =
                                snapshot.data.docs[index];

                            return Quizcard(
                              title: documentSnapshot['title'],
                                image: documentSnapshot['image'],
                                documentSnapshot: documentSnapshot);
                          });
                    } else {
                      return Center(
                        child: CircularProgressIndicator(color: darkBlue),
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;

  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint paint = Paint();
    paint.color = color;
    paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height -
            radius); // width untuk ketengahkan indicator dan height untuk letak indicator bawah label
    canvas.drawCircle(offset + circleOffset, radius, paint);
  }
}
