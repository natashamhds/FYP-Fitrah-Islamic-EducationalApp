import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitrah/pages/Course/course_jawi.dart';
import 'package:fitrah/pages/Home/navpages/Home%20Page/course_card.dart';
import 'package:fitrah/config/configScheme.dart';
import 'package:fitrah/pages/Home/navpages/Home%20Page/quiz_card.dart';
import 'package:fitrah/widgets/app_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hexcolor/hexcolor.dart';

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
              height: 260,
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
                                      image: documentSnapshot['image1'],
                                      bio: documentSnapshot['bio']
                                          .replaceAll('\\n', '\n'),
                                      endColor: documentSnapshot['endColor'],
                                      documentSnapshot: documentSnapshot,
                                    );
                                  })
                              .animate()
                              .fade(duration: 1300.ms)
                              .slideX(
                                  begin: 1.0,
                                  end: 0.0,
                                  curve: Curves.fastOutSlowIn);
                        } else {
                          return Center(
                            child: CircularProgressIndicator(color: darkBlue),
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
                              child: const JawiCard(),
                            );
                          })
                      .animate()
                      .fade(duration: 1300.ms)
                      .slideX(begin: 1.0, end: 0.0, curve: Curves.fastOutSlowIn)
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
                          }).animate().fade(duration: 800.ms).slideX(begin: 1.0, end: 0.0, curve: Curves.fastOutSlowIn);
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

class JawiCard extends StatelessWidget {
  const JawiCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.only(right: 15, top: 10),
        width: 200,
        height: 275,
        decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: HexColor('#FFB295').withOpacity(0.6),
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
                colors: [HexColor('#FE95B6'), HexColor('#FFB295')],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: const Padding(
            padding: EdgeInsets.only(top: 80, left: 16, right: 16, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Cara Menulis Jawi",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontFamily: 'circe',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 0.2,
                        color: Colors.white)),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Belajar bagaimana \n cara menulis \n dan menyebut \n huruf Jawi",
                                style: TextStyle(
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
          child: SizedBox(
            child:
                Image.asset('assets/images/pencil.png', width: 88, height: 80),
          ))
    ]);
  }
}

// ignore: must_be_immutable
class CircleTabIndicator extends Decoration {
  CircleTabIndicator({required this.color, required this.radius});

  final Color color;
  double radius;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  _CirclePainter({required this.color, required this.radius});

  final Color color;
  double radius;

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
