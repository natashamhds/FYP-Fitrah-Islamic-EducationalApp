// LIHAT MARKAH SKRIN
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitrah/config/configScheme.dart';
import 'package:fitrah/widgets/app_text.dart';
import 'package:flutter/material.dart';

class BarItemPage extends StatefulWidget {
  const BarItemPage({super.key});

  @override
  State<BarItemPage> createState() => _BarItemPageState();
}

class _BarItemPageState extends State<BarItemPage> {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);
    CollectionReference userRef = userDocRef.collection('anak');
    
    return Scaffold(
        backgroundColor: lightBlue,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              StreamBuilder(
        stream: FirebaseFirestore.instance
                          .collection('users')
                          .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading...");
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text('No data available');
          }
          
          final subcollectionText = snapshot.data!.docs
              .map((doc) => '${doc.data()}')
              .join();

          return Container(
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: darkBlue),
                  child: Center(
                      child: AppText(
                    text: subcollectionText,
                    size: 30,
                    color: Colors.white,
                  )));
        }),
              
              const SizedBox(height: 15),
              AppText(
                  text: "Sejarah Soalan Pengukuhan", size: 25, color: darkBlue),
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(text: "Adab Belajar", size: 20),
                    AppText(text: "100%", size: 20, color: darkBlue)
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
