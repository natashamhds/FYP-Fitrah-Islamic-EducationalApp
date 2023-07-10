// LIHAT MARKAH SKRIN
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitrah/config/configScheme.dart';
import 'package:fitrah/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BarItemPage extends StatefulWidget {
  const BarItemPage({super.key});

  @override
  State<BarItemPage> createState() => _BarItemPageState();
}

class _BarItemPageState extends State<BarItemPage> {
  final currentUser = FirebaseAuth.instance.currentUser;

  void successfullyDelete() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: AwesomeSnackbarContent(
        title: "Sejarah kuiz berjaya diapadam",
        message: "Anda kini boleh cuba menjawab sekali lagi",
        color: Colors.lightGreen,
        contentType: ContentType.success,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightBlue,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                AppText(
                    text: "Sejarah Soalan Pengukuhan",
                    size: 25,
                    color: darkBlue),
                const SizedBox(height: 20),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(currentUser!.uid)
                        .collection('anak')
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(color: darkBlue));
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(
                            child: AppText(text: "Uh-oh, Tiada maklumat!", size: 22));
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot documentSnapshot =
                                snapshot.data!.docs[index];
                            return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Slidable(
                                    endActionPane: ActionPane(
                                        motion: const DrawerMotion(),
                                        children: [
                                          SlidableAction(
                                              backgroundColor: Colors.redAccent,
                                              icon: Icons.delete_forever,
                                              onPressed: (context) => {
                                                    snapshot.data.docs[index]
                                                        .reference
                                                        .delete(),
                                                    successfullyDelete()
                                                  })
                                        ]),
                                    child: ListTile(
                                      title: AppText(
                                          text: documentSnapshot['anakName'],
                                          size: 30),
                                      subtitle: Text(
                                          documentSnapshot['subjectName'],
                                          style: const TextStyle(fontSize: 20)),
                                      trailing: Wrap(
                                        spacing: 12,
                                        children: <Widget>[
                                          AppText(
                                              text:
                                                  "${documentSnapshot['subjectScore']}%",
                                              size: 30),
                                        ],
                                      ),
                                    ))).animate().fade(duration: 800.ms).slideY(begin: 1.0, end: 0.0, curve: Curves.fastOutSlowIn);
                          });
                    }),
              ],
            ),
          ),
        ));
  }
}
