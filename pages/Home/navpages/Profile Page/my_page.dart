import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitrah/config/configScheme.dart';
import 'package:fitrah/pages/Home/main_page.dart';
import 'package:fitrah/pages/Home/navpages/Profile%20Page/anak_card.dart';
import 'package:fitrah/pages/Home/navpages/Profile%20Page/edit_page.dart';
import 'package:fitrah/pages/Home/navpages/Profile%20Page/about_app.dart';
import 'package:fitrah/widgets/app_large_text.dart';
import 'package:fitrah/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // getDocId();
    super.initState();
    initAuth();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // DocumentReference userDocRef =
    //     FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);
    // CollectionReference userRef = userDocRef.collection('anak');
    return Scaffold(
      backgroundColor: lightBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: '${currentUser?.photoURL}',
              placeholder: (context, url) =>
                  CircularProgressIndicator(color: darkBlue),
              cacheManager: CacheManager(Config('customCacheKey',
                  stalePeriod: const Duration(days: 2))),
              imageBuilder: (context, imageProvider) {
                return SizedBox(
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(image: imageProvider),
                    ));
              },
            ),
            const SizedBox(height: 15),
            Text(currentUser!.displayName!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'circe',
                    fontSize: 20)),
            const SizedBox(height: 20),
            Container(
              width: size.width * 0.6,
              height: size.width * 0.43,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  TextButton.icon(
                      onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EditPage()),
                            )
                          },
                      icon: Icon(
                        Icons.edit,
                        color: purple,
                      ),
                      label: Text("Kemaskini Akaun",
                          style: TextStyle(
                              color: purple,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'circe',
                              fontSize: 18))),
                  TextButton.icon(
                      onPressed: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => makeDismissible(
                            child: DraggableScrollableSheet(
                              expand: false,
                              initialChildSize: 0.7,
                              minChildSize: 0.5,
                              maxChildSize: 0.9,
                              builder: (context, scrollController) =>
                                  SingleChildScrollView(
                                controller: scrollController,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(30))),
                                  padding: const EdgeInsets.all(30),
                                  child: Column(
                                    children: [
                                      AppLargeText(
                                          text: "Urus Akaun Anak", size: 25),
                                      const SizedBox(height: 15),
                                      StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(currentUser!.uid)
                                              .collection('anak')
                                              .snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            if (snapshot.hasData) {
                                              List<DocumentSnapshot> anakDocs =
                                                  snapshot.data!.docs;
                                              return ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: anakDocs.length,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    DocumentSnapshot anak =
                                                        anakDocs[index];
                                                    return AnakCard(
                                                      name: anak['name'],
                                                      documentSnapshot: anak,
                                                    );
                                                  });
                                            } else {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: darkBlue),
                                              );
                                            }
                                          }),
                                      GestureDetector(
                                        onTap: () => {
                                          Navigator.pop(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MainPage()))
                                        },
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(right: 30),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 90,
                                                height: 90,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: const Icon(Icons.add),
                                                ),
                                              ),
                                              AppText(
                                                text: "Tambah Akaun Anak",
                                                color: darkBlue,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.add,
                        color: purple,
                      ),
                      label: Text("Urus Akaun Anak",
                          style: TextStyle(
                              color: purple,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'circe',
                              fontSize: 18))),
                  TextButton.icon(
                      onPressed: signOut,
                      icon: Icon(Icons.logout, color: purple),
                      label: Text("Log Keluar",
                          style: TextStyle(
                              color: purple,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'circe',
                              fontSize: 18))),
                ],
              ),
            ),
            const SizedBox(height: 50),
            TextButton.icon(
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AboutApp()),
                      )
                    },
                icon: Icon(Icons.info_outline_rounded, color: purple),
                label: Text("Tentang Aplikasi",
                    style: TextStyle(
                        color: purple,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'circe',
                        fontSize: 18))),
          ],
        ),
      ),
    );
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  late FirebaseAuth _auth;
  final _user = Rxn<User>();
  late Stream<User?> _authStateChanges;

  void initAuth() async {
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value = user;
    });
  }

  User? getUser() {
    _user.value = _auth.currentUser;
    return _user.value;
  }

  Widget makeDismissible({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(onTap: () {}, child: child),
      );

  void deleteCachedImage() {
    CachedNetworkImage.evictFromCache('${currentUser?.photoURL}');
  }
}
