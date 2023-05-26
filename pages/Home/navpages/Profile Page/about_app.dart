import 'package:fitrah/config/configScheme.dart';
import 'package:flutter/material.dart';
import 'my_page.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightBlue,
        appBar: AppBar(
          title: const Text("TENTANG APLIKASI",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'circe')),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            //the first icon always named as leading
            onPressed: () {
              Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => const MyPage()));
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
        body: Column(
        children: [
          const SizedBox(height: 70),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: const Text(
                  "Gambar diambil daripada .... \nVideo diambil daripada \nAplikasi ini bertujuan untuk menyiapkan Projek Tahun Akhir",
                  style: TextStyle(fontSize: 16)),
            ),
          )
        ]));
  }
}
