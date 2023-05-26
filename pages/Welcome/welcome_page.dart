import 'package:fitrah/config/configScheme.dart';
import 'package:fitrah/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Animate(
              effects: [FadeEffect(duration: 1300.ms)],
              child: Container(
                width: MediaQuery.of(context)
                    .size
                    .width, //create container based on device's width
                height: MediaQuery.of(context)
                    .size
                    .width*0.9,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('asset/images/splash.png'),
                        fit: BoxFit.contain)),
              ),
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              const Text(
                "DIMANA KANAK-KANAK BELAJAR MENGENALI ISLAM",
                style: TextStyle(fontSize: 12, fontFamily: 'circe'),
              ),
              const Text("Memupuk Rasa Cinta \n & \n Membina Iman",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'circe'),
                  textAlign: TextAlign.center),
              const Text(
                  "Akhlak-akhlak indah nabi, \n dan mengenali huruf Jawi \n hanya dengan beberapa klik sahaja",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'circe'),
                  textAlign: TextAlign.center),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AuthPage()));
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
