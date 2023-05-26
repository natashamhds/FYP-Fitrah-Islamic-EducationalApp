import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitrah/config/configScheme.dart';
import 'package:fitrah/pages/Home/main_page.dart';
import 'package:fitrah/widgets/app_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AnakCard extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  final String name;
  String? image;
  Icon? icon;
  Icon? icon1;
  final Function()? onTap;

  AnakCard(
      {super.key,
      required this.documentSnapshot,
      required this.name,
      this.image,
      this.icon,
      this.icon1,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
              Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => const MainPage()))
            },
        child: Container(
          margin: const EdgeInsets.only(right: 30),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 90,
                height: 90,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: const Image(
                        image: AssetImage("asset/images/boy1.png"),
                        fit: BoxFit.cover)),
              ),
              AppText(
                text: name,
                color: darkBlue,
              ),
              IconButton(
                  icon: const Icon(Icons.check),
                  color: Colors.teal,
                  onPressed: () => {
                        Navigator.pop(context,
                            MaterialPageRoute(builder: (context) => MainPage()))
                      }),
              IconButton(
                  icon: const Icon(Icons.delete),
                  color: Colors.grey,
                  onPressed: () => {
                        // _delete(documentSnapshot.id)
                      })
            ],
          ),
        ));
  }
}
